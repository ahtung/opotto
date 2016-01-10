require 'spec_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller, focus: true do
  describe "#annonymous user" do
    let(:user) { build(:user) }

    context "when google_oauth2 email doesn't exist in the system" do
      before(:each) do
        stub_env_for_omniauth
        get :google_oauth2
        @user = User.find_by(email: user.email)
      end

      it { @user.should_not be_nil }
      it { should be_user_signed_in }
      it { response.should redirect_to tasks_path }
    end

    context "when google_oauth2 email already exist in the system" do
      before(:each) do
        stub_env_for_omniauth

        User.create!(:email => "ghost@nobody.com", :password => "my_secret")
        get :google_oauth2
      end

      it { flash[:notice].should == "Your email ghost@nobody.com is already exist in the system. You need to sign in first."}

      it { response.should redirect_to new_user_session_path }
    end
  end

  describe "#logged in user" do
    context "when user don't have google_oauth2 authentication" do
      before(:each) do
        stub_env_for_omniauth

        user = User.create!(:email => "user@example.com", :password => "my_secret")
        sign_in user

        get :google_oauth2
      end

      it "should add google_oauth2 authentication to current user" do
        user = User.where(:email => "user@example.com").first
        user.should_not be_nil
        fb_authentication = user.authentications.where(:provider => "google_oauth2").first
        fb_authentication.should_not be_nil
        fb_authentication.uid.should == "1234"
      end

      it { should be_user_signed_in }

      it { response.should redirect_to authentications_path }

      it { flash[:notice].should == "google_oauth2 is connected with your account."}

      it "should alias #google_oauth2 to #auth_all" do
        expect(subject.google_oauth2).to eq(subject.auth_all)
      end
    end

    context "when user already connect with google_oauth2" do
      before(:each) do
        stub_env_for_omniauth

        user = User.create!(:email => "ghost@nobody.com", :password => "my_secret")
        user.authentications.create!(:provider => "google_oauth2", :uid => "1234")
        sign_in user

        get :google_oauth2
      end

      it "should not add new google_oauth2 authentication" do
        user = User.where(:email => "ghost@nobody.com").first
        user.should_not be_nil
        fb_authentications = user.authentications.where(:provider => "google_oauth2")
        fb_authentications.count.should == 1
      end

      it { should be_user_signed_in }

      it { flash[:notice].should == "Signed in successfully." }

      it { response.should redirect_to tasks_path }

      it "should alias #google_oauth2 to #auth_all" do
        expect(subject.google_oauth2).to eq(subject.auth_all)
      end
    end
  end

end

def stub_env_for_omniauth
  request.env['devise.mapping'] = Devise.mappings[:user]
  request.env['omniauth.auth'] = omniauth_hash(user.email)
end

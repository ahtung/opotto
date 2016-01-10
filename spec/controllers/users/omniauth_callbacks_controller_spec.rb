require 'spec_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  let(:user) { build(:user) }

  describe '#annonymous user' do
    context "when google_oauth2 email doesn't exist in the system" do
      before(:each) do
        stub_env_for_omniauth
        get :google_oauth2
        @user = User.find_by(email: user.email)
      end

      it { @user.should_not be_nil }
      it { should be_user_signed_in }
      it { response.should redirect_to root_path }
    end

    context "when google_oauth2 email already exist in the system" do
      before(:each) do
        stub_env_for_omniauth
        create(:user, email: user.email)
        get :google_oauth2
        @user = User.find_by(email: user.email)
      end

      it { flash[:notice].should == "Successfully authenticated from Google account."}
      it { response.should redirect_to root_path }
    end
  end

  describe "#logged in user" do
    before(:each) do
      stub_env_for_omniauth
      @user = create(:user, email: user.email)
      sign_in @user
      get :google_oauth2
    end

    it { should be_user_signed_in }
    it { response.should redirect_to root_path }
    it { flash[:notice].should == "Successfully authenticated from Google account."}
  end
end

def stub_env_for_omniauth
  request.env['devise.mapping'] = Devise.mappings[:user]
  request.env['omniauth.auth'] = omniauth_hash(user.email)
end

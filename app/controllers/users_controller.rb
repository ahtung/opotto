# UsersController
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :authorize_user
  after_action :verify_authorized

  decorates_assigned :pots

  # GET /:id
  def show
    if params[:by] == 'invited'
      show_invitations
    elsif params[:by] == 'contributed'
      show_contributions
    else
      show_pots
    end
  end

  private

  def show_pots
    @pots = current_user.pots
    @title = t('site.navigation.mypots')
  end

  def show_invitations
    @pots = current_user.invited_pots
    @title = 'My Invitations'
  end

  def show_contributions
    @pots = current_user.contributed_pots
    @title = 'My Contributions'
  end

  def set_user
    @user = current_user.decorate
  end

  def authorize_user
    authorize @user
  end
end

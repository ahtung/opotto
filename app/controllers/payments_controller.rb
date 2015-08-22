# PaymentsController
class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contribution, only: [:success, :failure]
  after_action :verify_authorized

  # payment success
  def success
    authorize @contribution
    @contribution.success! if @contribution.initiated?
  end

  # payment failure
  def failure
    authorize @contribution
    @contribution.error! if @contribution.initiated?
  end

  private

  def set_contribution
    @contribution = Contribution.find(params[:contribution])
  end
end

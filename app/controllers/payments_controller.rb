# PaymentsController
class PaymentsController < ApplicationController
  before_action :set_contribution
  # payment success
  def success
    PaymentsWorker.perform_in(@contribution.payment_time, @contribution.id)
  end

  # payment failure
  def failure
  end

  private

  def set_contribution
    @contribution = Contribution.where(payment_key: params[:payment_key]).first
  end
end

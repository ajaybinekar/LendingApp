# frozen_string_literal: true

class LoanAdjustmentService
  def initialize(loan, adjustment_params)
    @loan = loan
    @adjustment_params = adjustment_params
  end

  def adjust
    @loan.adjustments.create(@adjustment_params)
    @loan.update(
      status: 'waiting_for_adjustment_acceptance',
      amount: @adjustment_params[:amount],
      interest_rate: @adjustment_params[:interest_rate]
    )
  end

  def accept
    @loan.update(status: 'open')
    @loan.user # Assuming you have access to the user through the loan
  end
end

class InterestCalculatorJob < ApplicationJob
  queue_as :default

  def perform
    Loan.where(status: 'open').find_each do |loan|
      interest = (loan.amount * (loan.interest_rate / 100) / (365 * 24 * 12) * 5)
      loan.update(amount: loan.amount + interest)
    end
  end
end
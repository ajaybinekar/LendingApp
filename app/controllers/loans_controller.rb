class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :confirm, :repay, :approve, :reject, :adjust, :accept_adjustment, :reject_adjustment]
  before_action :authenticate_user!
  before_action :check_admin, only: [:approve, :reject, :adjust]

  def index
    @loans = current_user.admin? ? Loan.all : current_user.loans
  rescue StandardError => e
    handle_error(e, 'Unable to fetch loans.')
  end

  def new
    @loan = Loan.new
  end

  def create
    @loan = current_user.loans.new(loan_params)
    @loan.status = :requested
    if @loan.save
      redirect_to loans_path, notice: 'Loan request submitted.'
    else
      render :new
    end
  rescue StandardError => e
    handle_error(e, 'Error creating loan request.')
  end

  def show
  end

  def repay
    service = LoanRepaymentService.new(@loan, current_user)
    result = service.repay
    redirect_to @loan, notice: result[:notice]
  rescue StandardError => e
    handle_error(e, 'Error during loan repayment.')
  end

  def approve
    LoanApprovalService.new(@loan).approve
    redirect_to loans_path, notice: 'Loan approved.'
  rescue StandardError => e
    handle_error(e, 'Error approving loan.')
  end

  def reject
    LoanApprovalService.new(@loan).reject
    redirect_to loans_path, notice: 'Loan rejected.'
  rescue StandardError => e
    handle_error(e, 'Error rejecting loan.')
  end

  def adjust
    LoanAdjustmentService.new(@loan, adjustment_params).adjust
    redirect_to loans_path, notice: 'Loan adjusted.'
  rescue StandardError => e
    handle_error(e, 'Error adjusting loan.')
  end

  def accept_adjustment
    if @loan.amount.nil? || @loan.interest_rate.nil?
      redirect_to @loan, alert: 'Loan amount or interest rate is not set.'
      return
    end

    admin_user = User.find_by(role: 'admin')
    service = LoanAdjustmentService.new(@loan, {})
    service.accept
    MoneyTransferService.new(admin_user, @loan.user, @loan.amount).transfer

    redirect_to @loan, notice: 'Adjustment accepted and loan is now open.'
  rescue StandardError => e
    handle_error(e, 'Error accepting adjustment.')
  end

  def reject_adjustment
    @loan.update(status: :rejected)
    redirect_to loans_path, notice: 'Adjustment rejected.'
  rescue StandardError => e
    handle_error(e, 'Error rejecting adjustment.')
  end

  def request_readjustment
    @loan.update(status: :readjustment_requested)
    redirect_to @loan, notice: 'Readjustment requested.'
  rescue StandardError => e
    handle_error(e, 'Error requesting readjustment.')
  end

  private

  def set_loan
    @loan = Loan.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    handle_error(e, 'Loan not found.')
  end

  def loan_params
    params.require(:loan).permit(:amount, :interest_rate)
  end

  def adjustment_params
    params.require(:adjustment).permit(:amount, :interest_rate)
  end

  def check_admin
    unless current_user.admin?
      redirect_to loans_path, alert: 'You are not authorized to perform this action.'
    end
  end

  def handle_error(exception, message)
    Rails.logger.error("#{message}: #{exception.message}")
    redirect_to loans_path, alert: message
  end
end

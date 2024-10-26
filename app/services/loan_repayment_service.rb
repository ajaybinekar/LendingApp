class LoanRepaymentService
    def initialize(loan, user)
      @loan = loan
      @user = user
    end
  
    def repay
      total_amount = @loan.amount + @loan.interest_rate
  
      if @user.wallet >= total_amount
        admin_user = User.find_by(role: 'admin')
        MoneyTransferService.new(@user, admin_user, total_amount).transfer
        @loan.update(status: :closed)
        return { notice: 'Loan repaid successfully.' }
      else
        MoneyTransferService.new(@user, @loan.admin, @user.wallet.balance).transfer
        @loan.update(status: :closed)
        return { notice: 'Partial repayment made. Loan closed.' }
      end
    end
  end
  
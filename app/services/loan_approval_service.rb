class LoanApprovalService
    def initialize(loan)
      @loan = loan
    end
  
    def approve
      @loan.update(status: :approved)
    end
  
    def reject
      @loan.update(status: :rejected)
    end
  end
  
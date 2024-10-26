class MoneyTransferService
    def initialize(from_user, to_user, amount)
      @from_user = from_user
      @to_user = to_user
      @amount = amount
    end
  
    def transfer
      ActiveRecord::Base.transaction do
        @from_user.update!(wallet: @from_user.wallet - @amount)
        @to_user.update!(wallet: @to_user.wallet + @amount)
      end
    end
  end
  
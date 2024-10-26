module LoansHelper
    def loan_status_class(status)
      case status
      when 'open'
        'badge-success'
      when 'approved'
        'badge-primary'
      when 'rejected'
        'badge-danger'
      when 'requested'
        'badge-warning'
      else
        'badge-secondary'
      end
    end
  end
  
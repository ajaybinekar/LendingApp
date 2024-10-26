class Loan < ApplicationRecord
  belongs_to :user
  has_many :adjustments
    enum status: {
      requested: 'requested',
      approved: 'approved',
      open: 'open',
      closed: 'closed',
      rejected: 'rejected',
      waiting_for_adjustment_acceptance: 'waiting_for_adjustment_acceptance',
      readjustment_requested: 'readjustment_requested'
    }
  
    serialize :adjustments, Array  
end

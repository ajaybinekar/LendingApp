# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { user: 0, admin: 1 }
  after_initialize :set_default_wallet
  has_many :loans
  def set_default_wallet
    self.wallet ||= 10_000 if user?
    self.wallet ||= 1_000_000 if admin?
  end
end

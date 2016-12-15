class Account < ApplicationRecord
  belongs_to :user
  has_many :kudos, dependent: :destroy
  has_and_belongs_to_many :teams
  has_many :account_teams

  class << self
    def from_user(user)
      Account.where(user_id: user.id).first
    end
  end
end

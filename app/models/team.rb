class Team < ApplicationRecord
  belongs_to :leader, class_name: :Account, foreign_key: :leader_id
  has_many :kudos, dependent: :destroy
  has_many :totals, dependent: :destroy
  has_and_belongs_to_many :accounts
  has_many :account_teams
  validates :name, presence: true
  validates :sprint_days, inclusion: {in: (1..365)}

end

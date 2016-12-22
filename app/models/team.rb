class Team < ApplicationRecord
  belongs_to :leader, class_name: :Account, foreign_key: :leader_id
  has_many :kudos, dependent: :destroy
  has_many :totals, dependent: :destroy
  has_and_belongs_to_many :accounts
  has_many :account_teams
  validates :name, presence: true
  validates :sprint_days, inclusion: {in: (1..365)}

  def sprint_end_day?
    days_left_in_sprint == 0
  end

  def days_left_in_sprint
    (DateTime.now.to_i - start_date.to_datetime.to_i)/24/60/60 % sprint_days
  end
end

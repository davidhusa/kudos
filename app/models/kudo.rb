class Kudo < ApplicationRecord
  belongs_to :to, class_name: :Account, foreign_key: :to_id
  belongs_to :from, class_name: :Account, foreign_key: :from_id
  belongs_to :team
  validates :sprint, presence: true
  after_create :up_total
  TOO_MANY_KUDOS = "Too many kudos this sprint"

  def up_total
    [Total.find_or_create_by(to_id: to_id, from_id: from_id, team_id: team_id), # atomic
     Total.find_or_create_by(to_id: to_id, from_id: from_id, team_id: nil),     # all given
     Total.find_or_create_by(to_id: to_id, from_id: nil, team_id: team_id)      # given on time
     ].each do |total|
      total.update_attribute(:kudos, total.kudos += 1)
    end
  end

  def save_if_applicable(current_account)
    if too_many_kudos?(current_account)
      errors.add(:from, TOO_MANY_KUDOS)
      false
    else
      save
    end
  end

  def too_many_kudos?(current_account)
    errors[:from].include?(TOO_MANY_KUDOS) ||
      Kudo.where(from_id: current_account.id, sprint: team.sprint, team_id: self.team_id).all.size >= ENV["MAX_KUDOS"].to_i
  end
end

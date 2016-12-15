class Kudo < ApplicationRecord
  belongs_to :to, class_name: :Account, foreign_key: :to_id
  belongs_to :from, class_name: :Account, foreign_key: :from_id
  belongs_to :team
  after_create :up_total
  TOO_MANY_KUDOS = "Too many kudos this sprint"

  def up_total
    [specific_total = Total.find_or_create_by(to_id: to_id, from_id: from_id, team_id: team_id),
    personal_total = Total.find_or_create_by(to_id: to_id, from_id: from_id, team_id: nil),
    team_total = Total.find_or_create_by(to_id: to_id, from_id: nil, team_id: team_id)].each do |total|
      total.update_attribute(:kudos, total.kudos += 1)
    end
  end

  def save_if_applicable
    if too_many_kudos?
      save
    else
      errors.add(:to, TOO_MANY_KUDOS)
      false
    end
  end

  def too_many_kudos?
    errors[:to].includes? TOO_MANY_KUDOS ||
     where(from_id: current_account.id, sprint: current_sprint, team_id: self.team_id).all.size < ENV["MAX_KUDOS"].to_i
  end
end

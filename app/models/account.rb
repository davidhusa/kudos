class Account < ApplicationRecord
  belongs_to :user
  has_many :kudos_given, dependent: :destroy, class_name: :Kudo, foreign_key: :from_id
  has_many :kudos_taken, dependent: :destroy, class_name: :Kudo, foreign_key: :to_id
  has_many :total_kudos_given, dependent: :destroy, class_name: :Total, foreign_key: :from_id
  has_many :total_kudos_taken, dependent: :destroy, class_name: :Total, foreign_key: :to_id


  has_and_belongs_to_many :teams
  has_many :account_teams
  has_attached_file :photo, styles: { large: "400x400>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  class << self
    def from_user(user)
      Account.where(user_id: user.id).first
    end
  end

  def total_kudos(team)
    Total.where(to_id: self.id, team_id: team.id).where.not(from_id: nil).all.map(&:kudos).inject(0, :+)
  end

  def date_joined(team)
    AccountsTeam.where(team_id: team.id, account_id: self.id).first.created_at
  end

  def totals
    return @totals if @totals
    @totals = {}

    @totals[:all_taken] = Total.where(to_id: self.id, team_id: nil).all.map(&:kudos).inject(0, :+)
    @totals[:all_given] = Total.where(from_id: self.id, team_id: nil).all.map(&:kudos).inject(0, :+)
    
    @totals[:teams_taken] = Total.where(to_id: self.id).where.not(team_id: nil).all.map { |t| [t.team_id, t.kudos] }.to_h
    @totals[:teams_given] = Total.where(to_id: self.id).where.not(team_id: nil).all.map { |t| [t.team_id, t.kudos] }.to_h

    @totals
  end

  def kudos_this_sprint
    teams.map do |t|
      to = Kudo.where(sprint: t.sprint, to_id: self.id).all
      from = Kudo.where(sprint: t.sprint, from_id: self.id).all
      (to + from).sort_by(&:created_at)
    end
  end

  def needs_customization?
    created_at == updated_at
  end
end

# Total.find_or_create_by(to_id: to_id, from_id: from_id, team_id: team_id), # atomic
# Total.find_or_create_by(to_id: to_id, from_id: from_id, team_id: nil    ), # all given
# Total.find_or_create_by(to_id: to_id, from_id: nil,     team_id: team_id)  # given on time

     # <td><%= member.total_kudos(team) %></td>
     #    <td><%= member.date_joined(team) %></td>


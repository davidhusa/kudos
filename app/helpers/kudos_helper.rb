module KudosHelper
  def kudos_path
    team_kudos_path(@team)
  end

  def kudo_path(kudo)
    team_kudo_path(@team, kudo)
  end

  def to_field(team, kudo)
    options_for_select(team.accounts.map {|a| [a.name, a.id]}.sort_by {|a| a[1] == kudo.to_id ? 0 : 1})
  end
end

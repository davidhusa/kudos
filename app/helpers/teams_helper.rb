module TeamsHelper
  def join_or_quit(team)
    if team.accounts.include?(current_account)
      link_to 'Quit', quit_team_path(team)
    else
      link_to 'Join', join_team_path(team)
    end
  end

  def member_names(team, max_length = 64)
    team.accounts.map(&:name).join(', ')
  end

  def leader_name(team)
    team.leader ? team.leader.name : "N/A"
  end
end

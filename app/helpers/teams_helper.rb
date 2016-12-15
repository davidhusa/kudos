module TeamsHelper
  def join_or_quit(team)
    if team.accounts.include?(current_account)
      link_to 'Quit', quit_team_path(team)
    else
      link_to 'Join', join_team_path(team)
    end
  end

  def leader?(team)
    current_account && Team.where(leader_id: current_account.id).all.include?(team)
  end
end

module ApplicationHelper
  def navigation_links
    links = []
    unless current_user
      flash[:weclome_notice] = "Weclome to Kudos!"
      return links
    end

    links << (email_or_account_name + ' (' + link_to("Log out", destroy_user_session_path, method: :delete) + ')')
    links << link_to("Teams", teams_path) unless current_account.needs_customization? || (controller_name == 'teams')

    links << link_to("Account", edit_account_path(current_account)) if current_account && !(controller_name == 'accounts' && action_name == 'edit')
    if admin?
      links << link_to("Manage Accounts", accounts_path)
      links << ("Focused on " + (current_account.name || "") + " (" + link_to("unfocus", request.env['PATH_INFO']+"?focus=0")+")") if focused?
    end

    links
  end

  def email_or_account_name
    return current_account.name if current_account && !current_account.name.blank?
    current_user.email
  end
end
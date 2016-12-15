module ApplicationHelper
  def navigation_links
    links = []
    if current_user
      links << link_to("Log out", destroy_user_session_path, method: :delete)
      links << link_to("Teams", teams_path)
      links << link_to("Kudos", kudos_path)
    else
      if controller_name == 'registrations'
        links << link_to("Log In", new_user_session_path) 
      else
        links << link_to("Sign Up", new_user_registration_path)
      end
    end
    links << link_to("Account", edit_account_path(current_account)) if current_account
    if admin?
      links << link_to("Manage Accounts", accounts_path) 
      links << ("Focused on " + (current_account.name || "") + " (" + link_to("unfocus", request.env['PATH_INFO']+"?focus=0")+")") if focused?
    end

    links
  end
end
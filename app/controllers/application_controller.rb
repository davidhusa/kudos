class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :admin?, :focused?, :current_account

  def after_sign_in_path_for(resource)
    if request.referer == new_user_session_url
      super
    else
      if current_account.name.blank?
        new_account_url
      else
        teams_url
      end
    end
  end

  def customize_account_if_needed
    if current_account.needs_customization?
      flash[:notice] = "Welcome to Kudos, the world's only web app for giving and receiving Kudos. Update your profile, join your team, and give up your three kudos!!"
      redirect_to edit_account_url(current_account)
    end
  end

  def admin_only
    redirect_to teams_url unless admin?
  end

  def admin?
    !!current_user && current_user.admin?
  end

  def focused?
    cookies[:focus].to_i > 0
  end

  def leader?(team)
    current_account && Team.where(leader_id: current_account.id).all.include?(team)
  end
  helper_method :leader?

  def current_account
    @current_account ||= if admin?
      cookies[:focus] = params[:focus] if params[:focus]
      Account.find_by_id(cookies[:focus].to_i) || current_user.account
    elsif current_user
      current_user.account
    end
  end
end

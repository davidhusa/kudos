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

  def make_account_if_needed
    redirect_to edit_account_url unless current_account
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

  def current_account
    @current_account ||= if admin?
      
      cookies[:focus] = params[:focus] if params[:focus]
      Account.find_by_id(cookies[:focus].to_i) || current_user.account
    elsif current_user
      current_user.account
    end
  end
end

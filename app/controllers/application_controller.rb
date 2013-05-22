# encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  helper_method :current_user, :current_client

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      store_location
      redirect_to login_user_path, :notice => "Musisz się zalogować, aby obejrzeć zawartość strony!"
      false
    end
  end

  def current_client_session
    return @current_client_session if defined?(@current_client_session)
    @current_client_session = ClientSession.find
  end

  def current_client
    return @current_client if defined?(@current_client)
    @current_client = current_client_session && current_client_session.record
  end

  def require_client
    unless current_client
      store_location
      redirect_to login_client_path
      false
    end
  end

  def require_no_client
    if current_client
      redirect_to current_client, :notice => "Klient o podanych danych jest zalogowany do systemu."
      false
    end
  end

  def check_login
    if params[:not_login] || session[:not_login]
      session[:not_login] = true
      true
    else
      session[:not_login] = nil
      unless current_client
        store_location
        redirect_to login_client_path
        false
      end
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def restore_location
    if session[:return_to].nil?
      if current_user
        return products_path
      else
        return root_url
      end
    else
      url = session[:return_to]
      session[:return_to] = nil
      url
    end
  end
end

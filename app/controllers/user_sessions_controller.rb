# encoding: utf-8

class UserSessionsController < ApplicationController

  layout "admin"

  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      session[:can_edit] = true
      redirect_to admin_orders_path, :notice => "Użytkownik został zalogowany poprawnie do systemu."
    else
      render :action => 'new'
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    session[:can_edit] = false
    redirect_to root_url, :notice => "Użytkownik został wylogowany poprawnie z systemu."
  end

end
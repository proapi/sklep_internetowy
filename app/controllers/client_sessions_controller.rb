# encoding: utf-8

class ClientSessionsController < ApplicationController

  layout "application"

  before_filter :require_client, :only => :destroy

  def new
    @client_session = ClientSession.new
  end

  def create
    @client_session = ClientSession.new(params[:client_session])
    if @client_session.save
      session[:order_step] = session[:order_params] = session[:not_login] = nil
      redirect_to(restore_location, :notice =>"Użytkownik został zalogowany poprawnie do systemu.")
    else
      render :action => 'new'
    end
  end

  def destroy
    @client_session = ClientSession.find
    @client_session.destroy
    session[:order_step] = session[:order_params] = session[:not_login] = nil
    redirect_to(login_client_url, :notice => "Użytkownik został wylogowany poprawnie z systemu.")
  end

end
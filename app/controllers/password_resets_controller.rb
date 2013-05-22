#encoding: utf-8

class PasswordResetsController < ApplicationController

  before_filter :require_no_client
  before_filter :load_client_using_perishable_token, :only => [:edit, :update]

  def new
  end

  def create
    @client = Client.find_by_email(params[:email])
    if @client
      @client.deliver_password_reset_instructions!
      flash[:notice] = "Instrukcje do wprowadzenia nowego hasła zostały wysłane na adres e-mail."
      redirect_to root_url
    else
      flash[:notice] = "Przykro nam, ale nie znaleziono konta o podanym adresie e-mail. Proszę spróbować jeszcze raz, bądź skontaktować się z obsługą sklepu"
      render :action => :new
    end
  end


  def edit
    render
  end

  def update
    @client.password = params[:client][:password]
    @client.password_confirmation = params[:client][:password_confirmation]
    if @client.save
      flash[:notice] = "Hasło zmienione poprawnie, proszę zapamiętać nowe hasło."
      redirect_to edit_client_path @client
    else
      render :action => :edit
    end
  end

  private
  def load_client_using_perishable_token
    @client = Client.find_using_perishable_token(params[:id])
    unless @client
      flash[:notice] = "Przepraszamy, system nie może znaleźć konta o podanych informacjach. Proszę spróbować skopiować link z otrzymanej wiadomości e-mail i wkleić do paska adresu przeglądarki. Jeżeli nadal pojawią się problemy proszę o kontakt z obsługą sklepu."
      redirect_to root_url
    end
  end

end
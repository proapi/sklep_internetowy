# encoding: utf-8
class ClientsController < ApplicationController

  layout "application"

  before_filter :check_permisions

  # GET /clients/1
  # GET /clients/1.xml
  def show
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.xml
  def new
    @client = Client.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /clients
  # POST /clients.xml
  def create
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
        session[:order_step] = session[:order_params] = session[:not_login] = nil
        format.html { redirect_to root_url, notice: 'Twoje konto zostało poprawnie utworzone, zapraszamy do zakupów.' }
        format.xml { render :xml => @client, :status => :created, :location => @client }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.xml
  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        flash[:notice] = 'Klient został zapisany poprawnie.'
        format.html { redirect_to edit_client_path(@client) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.xml
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    if @client.destroyed?
      flash[:notice] = 'Klient został usunięty poprawnie.'
    else
      flash[:notice] = 'Wystąpił błąd podczas usuwania klienta.'
    end

    respond_to do |format|
      format.html { redirect_to root_url }
      format.xml { head :ok }
    end
  end

  private
  def check_permisions
    if (current_client && (params[:id].to_i != current_client.id.to_i))
      flash[:notice] = "Nie masz uprawnień do oglądania zawartości tej strony!"
      redirect_to root_url and return
    end
  end

end

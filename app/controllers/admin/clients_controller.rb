# encoding: utf-8

class Admin::ClientsController < ApplicationController

  layout "admin"

  before_filter :require_user

  autocomplete :client, :last_name, :full => true

  # GET /clients
  # GET /clients.xml
  def index
    if params[:client]
      @search = Client.search :last_name_like => params[:client][:last_name]
      params.clear
    else
      @search = Client.search(params[:search])
    end

    @search.meta_sort ||= 'created_at.desc'

    @clients = @search.paginate(:per_page => 20, :page => params[:page])

    redirect_to admin_client_path(@clients.first, params) and return if (@clients.size.eql?(1))

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @clients }
    end
  end

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
  end

  # POST /clients
  # POST /clients.xml
  def create
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
        flash[:notice] = 'Konto klienta zostało stworzone poprawnie.'
        format.html { redirect_to([:admin, @client]) }
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
        flash[:notice] = 'Konto klienta zostało zapisane poprawnie.'
        format.html { redirect_to([:admin, @client]) }
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
      flash[:notice] = 'Konto klienta zostało usunięte poprawnie.'
    else
      flash[:notice] = 'Wystąpił błąd podczas usuwania konta klienta.'
    end

    respond_to do |format|
      format.html { redirect_to(admin_clients_url) }
      format.xml { head :ok }
    end
  end
end
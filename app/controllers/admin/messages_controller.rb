#encoding: utf-8

class Admin::MessagesController < ApplicationController

  layout "admin"

  before_filter :require_user

  # GET /admin/messages
  # GET /admin/messages.json
  def index
    if params[:message]
      @search = Message.search :name_like => params[:message][:name]
      params.clear
    else
      @search = Message.search(params[:search])
    end

    @messages = @search.paginate(:per_page => "20", :page => params[:page])

    if params[:search].nil? || params[:search][:meta_sort].nil?
      @messages = @messages.order("updated_at desc")
    end

    redirect_to admin_message_path(@messages.first, params) and return if (@messages.size.eql?(1))

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  # GET /admin/messages/1
  # GET /admin/messages/1.json
  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /admin/messages/new
  # GET /admin/messages/new.json
  def new
    if params[:client_id]
      @client = Client.find(params[:client_id])
      @message = @client.messages.build
    else
      @message = Message.new
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # NIEAKTYWNE WYŁĄCZONE PRZEZ ROUTES
  # GET /admin/messages/1/edit
  def edit
    @message = Message.find(params[:id])
  end

  # POST /admin/messages
  # POST /admin/messages.json
  def create
    @message = Message.new(params[:message])
    @message.user_id = current_user.id

    respond_to do |format|
      if @message.save
        format.html { redirect_to [:admin, @message], notice: 'Wiadomość wysłana poprawnie.' }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # NIEAKTYWNE WYŁĄCZONE PRZEZ ROUTES
  # PUT /admin/messages/1
  # PUT /admin/messages/1.json
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to [:admin, @message], notice: 'Wiadomość wysłana poprawnie.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/messages/1
  # DELETE /admin/messages/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    flash[:notice] = 'Wiadomość skasowana porpawnie' if @message.destroyed?

    respond_to do |format|
      format.html { redirect_to admin_messages_url }
      format.json { head :no_content }
    end
  end
end

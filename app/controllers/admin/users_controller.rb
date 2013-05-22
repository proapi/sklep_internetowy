# encoding: utf-8

class Admin::UsersController < ApplicationController

  layout "admin"

  before_filter :require_user

  autocomplete :user, :last_name, :full => true

  # GET /users
  # GET /users.xml
  def index
    if params[:user]
      @search = User.search :last_name_like => params[:user][:last_name]
      params.clear
    else
      @search = User.search(params[:search])
    end

    @search.meta_sort ||= 'created_at.desc'

    @users = @search.paginate(:per_page => "20", :page => params[:page])

    redirect_to admin_user_path(@users.first, params) and return if (@users.size.eql?(1))

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        flash[:notice] = 'Użytkownik został stworzony poprawnie.'
        format.html { redirect_to([:admin, @user]) }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'Użytkownik został zapisany poprawnie.'
        format.html { redirect_to([:admin, @user]) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    if @user.destroyed?
      flash[:notice] = 'Użytkownik został usunięty poprawnie.'
    else
      flash[:notice] = 'Wystąpił błąd podczas usuwania użytkownika.'
    end

    respond_to do |format|
      format.html { redirect_to(admin_users_url) }
      format.xml { head :ok }
    end
  end
end

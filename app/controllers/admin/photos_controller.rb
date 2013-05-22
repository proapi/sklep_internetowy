# encoding: utf-8

class Admin::PhotosController < ApplicationController

  layout "admin"

  before_filter :require_user

  autocomplete :photo, :title, :full => true

  # GET /photos
  # GET /photos.xml
  def index
    if params[:photo]
      @search = Photo.search :title_like => params[:photo][:title]
      params.clear
    else
      @search = Photo.search(params[:search])
    end

    @photos = @search.paginate(:per_page => 20, :page => params[:page])

    redirect_to admin_photo_path(@photos.first, params) and return if (@photos.size.eql?(1))

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.xml
  def new
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
  end

  # POST /photos
  # POST /photos.xml
  def create
    @photo = Photo.new(params[:photo])

    respond_to do |format|
      if @photo.save
        flash[:notice] = 'Plik został dodany poprawnie.'
        format.html { redirect_to admin_photos_path(:product_id => @photo.product_id) }
        format.xml { render :xml => @photo, :status => :created, :location => @photo }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.xml
  def update
    if request.xhr?
      @product = Product.find(params[:product][:id])

      @product.photos.each do |photo|
        photo.update_attribute(:main, false)
      end

      if params[:photo][:id].empty?
        return
      else
        @photo = Photo.find(params[:photo][:id])
      end

    else
      @photo = Photo.find(params[:id])
    end

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        flash[:notice] = 'Plik został zapisany poprawnie.' unless request.xhr?
        format.html { redirect_to([:admin, @photo]) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    if @photo.destroyed?
      flash[:notice] = 'Plik został usunięty poprawnie.'
    else
      flash[:notice] = 'Wystąpił błąd podczas usuwania pliku.'
    end

    respond_to do |format|
      format.html { redirect_to(admin_photos_url) }
      format.xml { head :ok }
    end
  end
end
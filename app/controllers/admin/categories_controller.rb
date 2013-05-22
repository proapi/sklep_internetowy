# encoding: utf-8

class Admin::CategoriesController < ApplicationController

  layout "admin"

  before_filter :require_user

  autocomplete :category, :name

  # GET /categories
  # GET /categories.xml
  def index
    if params[:category]
      @search = Category.search :name_like => params[:category][:name]
      params.clear
    else
      @search = Category.search(params[:search])
    end

    @categories = @search.paginate(:per_page => "20", :page => params[:page])

    redirect_to admin_category_path(@categories.first, params) and return if (@categories.size.eql?(1))

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        flash[:notice] = 'Kategoria została stworzona poprawnie.'
        format.html { redirect_to([:admin, @category]) }
        format.xml { render :xml => @category, :status => :created, :location => @category }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Kategoria została zapisana poprawnie.'
        format.html { redirect_to([:admin, @category]) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    if @category.destroyed?
      flash[:notice] = 'Kategoria została usunięta poprawnie.'
    else
      flash[:notice] = 'Wystąpił błąd podczas usuwania kategorii.'
    end

    respond_to do |format|
      format.html { redirect_to(admin_categories_url) }
      format.xml { head :ok }
    end
  end
end

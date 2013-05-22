# encoding: utf-8

class Admin::ProductsController < ApplicationController

  layout "admin", :except => [:set_visible]

  before_filter :require_user

  autocomplete :product, :name, :full => true

  # GET /products
  # GET /products.xml
  def index
    if params[:product]
      @search = Product.search :name_like => params[:product][:name]
      params.clear
    else
      @search = Product.search(params[:search])
    end

    @promo = true if params[:search] && params[:search][:is_promotion_is_true]

    @search.meta_sort ||= "name.asc"

    @products = @search.paginate(:per_page => 20, :page => params[:page])

    #w redirect_to musiałem zrobić zmianę, gdyż nie przekierowywało do poprawnej strony, tylko wstawiało zły id
    redirect_to [:admin, @products.first] and return if (@products.size.eql?(1))

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new
    @product.photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    @product.build_photo unless @product.photo
    @destination = "edit_" + (params[:destination].nil? ? "data" : params[:destination].to_s)

    respond_to do |format|
      format.html # edit.html.erb
    end
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        flash[:notice] = 'Produkt został stworzony poprawnie.'
        format.html { redirect_to([:admin, @product]) }
        format.xml { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    if params[:content]
      @product.description=params[:content][:product_description][:value]
    end

    logger.info params.inspect

    respond_to do |format|
      if @product.update_attributes(params[:product])
        flash[:notice] = 'Produkt został zmieniony poprawnie.'
        format.html { redirect_to([:admin, @product]) }
        format.xml { head :ok }
        format.json { render text: "", status: 200 }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @product.errors, :status => :unprocessable_entity }
        format.json { render text: "", status: 403 }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    if @product.destroyed?
      flash[:notice] = 'Produkt został usunięty poprawnie.'
    else
      flash[:notice] = 'Wystąpił błąd podczas usuwania produktu.'
    end

    respond_to do |format|
      format.html { redirect_to(admin_products_url) }
      format.xml { head :ok }
    end
  end

  #def remove_relation
  #  if request.xhr?
  #    relation = Relation.find(params[:relation_id])
  #    product = Product.find(params[:product_id])
  #
  #    product.relations.delete(relation)
  #
  #  end
  #
  #  render :update do |page|
  #    page.replace "refresh#{relation.id.to_s}"
  #  end
  #end
  #
  #def add_relation
  #  if request.xhr?
  #    relation = Relation.find(params[:relation][:id])
  #    product = Product.find(params[:product][:id])
  #
  #    begin
  #      product.relations.find(relation.id)
  #    rescue
  #      b = true
  #      product.relations<<(relation)
  #    end
  #
  #  end
  #
  #  render :update do |page|
  #    if b
  #      page.insert_html :bottom, "new_relation", "<div id='refresh#{relation.id}'><li>#{relation.name} #{link_to_remote image_tag('icons/delete.png', :style => 'width: 24px; height: 24px; vertical-align: middle; border: 0;'), :url => {:action => 'remove_relation', :product_id => product.id, :relation_id => relation.id}}</li></div>"
  #    end
  #  end
  #end

  # remote method
  def set_visible
    if request.xhr?
      @product = Product.find(params[:id]) unless params[:id].blank?
      visible = params[:visible].to_i unless params[:visible].blank?

      if (@product)&&([0, 1].include?(visible))
        @product.visible = visible.to_i
        @product.save

        respond_to do |format|
          format.js
        end
      end
    end
  end

end
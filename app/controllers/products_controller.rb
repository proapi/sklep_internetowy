# encoding: utf-8

class ProductsController < ApplicationController

  layout "application"

  # GET /products
  # GET /products.xml
  def index
    if params[:search] && params[:search][:meta_sort] && !params[:search][:meta_sort].empty?
      @search = Product.only_visible.search(params[:search])
    else
      @search = Product.only_visible.joins(:producer).order("producers.priority ASC, products.name ASC").search(params[:search])
    end
    @products = @search.paginate(:per_page => (params[:per_page] || 20), :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.where(visible: true).find(params[:id])

    #na tą chwilę musi tak zostać, ma to związek z wywołaniem javascriptowym z listy produktów, którego nie można przystosować do friendly_id
    if !@product.nil? && (request.path != product_path(@product))
      redirect_to @product, status: :moved_permanently and return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @product }
    end
  end
end
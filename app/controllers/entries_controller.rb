# encoding: utf-8

class EntriesController < ApplicationController

  layout "application"

  # GET /entries/site
  # GET /entries/site.xml
  def site
    if params[:title]
       @entry = Entry.find_by_title(params[:title])
    end

    unless @entry
      redirect_to root_url and return
    end

    if @entry.category
      if params[:search] && params[:search][:meta_sort] && !params[:search][:meta_sort].empty?
        @search = Product.only_visible.where('categories.id' => [@entry.category.id]).search(params[:search])
      else
        @search = Product.only_visible.joins(:producer).joins(:categories).where('categories.id' => [@entry.category.id]).order("producers.priority ASC, products.name ASC").search(params[:search])
      end
      @products = @search.paginate(:per_page => (params[:per_page] || 20), :page => params[:page])
    end

    respond_to do |format|
      format.html # site.html.erb
      format.xml { render :xml => @entry }
    end
  end
end

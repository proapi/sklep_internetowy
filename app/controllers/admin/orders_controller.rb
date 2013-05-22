# encoding: utf-8

class Admin::OrdersController < ApplicationController

  layout "admin"

  before_filter :require_user

  autocomplete :order, :number, :full => true

  # POST
  def mark_as_sent
    if request.xhr?
      if (params[:id])&&(params[:status])
        @order = Order.find(params[:id])
        status = params[:status].to_i
        if @order
          @order.status = status
          @order.save

          #FIXME to przenieść do modelu order nie wysyła się przy przypomnieniu(ponagleniu)
          OrderMailer.order_1(@order, false).deliver if status.eql?(5)

          respond_to do |format|
            format.js
          end
        end
      end
    end
  end

  # GET /orders
  # GET /orders.xml
  def index
    if params[:order]
      @search = Order.search :number_like => params[:order][:number]
      params.clear
    else
      @search = Order.search(params[:search])
    end

    @search.meta_sort ||= 'created_at.desc'

    @orders = @search.paginate(:per_page => 20, :page => params[:page])

    redirect_to admin_order_path(@orders.first, params) and return if (@orders.size.eql?(1))

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to([:admin, @order], :notice => 'Zamówienie stworzone poprawnie.') }
        format.xml { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
  def update
    @order = Orders.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to([:admin, @order], :notice => "Zamówienie zapisane poprawnie") }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(admin_orders_url) }
      format.xml { head :ok }
    end
  end
end

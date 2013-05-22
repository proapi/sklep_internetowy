# encoding: utf-8

class OrdersController < ApplicationController

  layout "application"

  before_filter :require_client, only: [:index, :show]
  before_filter :check_login, only: [:new, :create]

  #GET /orders
  #GET /orders.xml
  def index
    @orders = current_client.orders.order("created_at desc")

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @orders }
    end
  end

  # GET /orders/1/basket
  # GET /orders/1.xml/basket
  def basket
    @order_items = (session[:order_items] ||= Array.new)

    respond_to do |format|
      format.html # basket.html.erb
      format.xml { render :xml => @order }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Order.find(params[:id])
    @remote_ip = request.remote_ip

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @order }
    end
  end

  def new
    session[:order_params] ||= {}
    @order = Order.new(session[:order_params])
    @order.order_items = session[:order_items]
    @order.recalculate
    @order.client = current_client
    @order.current_step = session[:order_step]
  end

  def create
    session[:order_params].deep_merge!(params[:order]) if params[:order]
    @order = Order.new(session[:order_params])
    @order.order_items = session[:order_items]
    @order.recalculate
    @order.client = current_client
    @order.current_step = session[:order_step]
    if @order.valid?
      if params[:back_button]
        @order.previous_step
      elsif @order.last_step?
        @order.save if @order.all_valid?
      else
        @order.next_step
      end
      session[:order_step] = @order.current_step
    end

    if @order.new_record?
      render "new"
    else
      session[:order_step] = session[:order_params] = session[:order_items] = session[:not_login] = nil
      @remote_ip = request.remote_ip
      render "step_4"
    end
  end

  #GET /orders/1/edit
  #def edit
  #  @order = Order.find(params[:id])
  #end
  #
  #
  ## PUT /orders/1
  ## PUT /orders/1.xml
  #def update
  #  @order = Order.find params[:id], :include => :client
  #  if params[:target].eql?("step_4")
  #    @order.number = "#{@order.get_next_number}/#{Time.now.year}"
  #    @order.update_attribute(:number, "#{@order.get_next_number}/#{Time.now.year}")
  #  else
  #    @order.number = ""
  #    @order.update_attribute(:number, "")
  #  end
  #
  #  respond_to do |format|
  #    if @order.update_attributes(params[:order])
  #      #format.html { params[:target].nil? ? (OrderMailer.order_1(@order, false).deliver and OrderMailer.order_1(@order, true).deliver and redirect_to(@order, :notice => "Zamówienie zostało zgłoszone do realizacji. Na podany adres email została wysłana informacja z potwierdzeniem zamówienia.")) : render(params[:target]) }
  #      format.html { params[:target].nil? ? redirect_to(@order) : render(params[:target]) }
  #      format.xml { head :ok }
  #    else
  #      format.html { render :action => "edit" }
  #      format.xml { render :xml => @order.errors, :status => :unprocessable_entity }
  #    end
  #  end
  #end
end

# encoding: utf-8

class Admin::ProducersController < ApplicationController

  layout "admin"

  before_filter :require_user

  autocomplete :producer, :name, :full => true

  # GET /producers
  # GET /producers.xml
  def index
    if params[:producer]
      @search = Producer.search :name_like => params[:producer][:name]
      params.clear
    else
      @search = Producer.search(params[:search])
    end

    @producers = @search.paginate(:per_page => "10", :page => params[:page])

    redirect_to admin_producer_path(@producers.first, params) and return if (@producers.size.eql?(1))

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @producers }
    end
  end

  # GET /producers/1
  # GET /producers/1.xml
  def show
    @producer = Producer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @producer }
    end
  end

  # GET /producers/new
  # GET /producers/new.xml
  def new
    @producer = Producer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @producer }
    end
  end

  # GET /producers/1/edit
  def edit
    @producer = Producer.find(params[:id])
  end

  # POST /producers
  # POST /producers.xml
  def create
    @producer = Producer.new(params[:producer])

    respond_to do |format|
      if @producer.save
        flash[:notice] = 'Wydawca został stworzony poprawnie.'
        format.html { redirect_to([:admin, @producer]) }
        format.xml { render :xml => @producer, :status => :created, :location => @producer }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @producer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /producers/1
  # PUT /producers/1.xml
  def update
    @producer = Producer.find(params[:id])

    respond_to do |format|
      if @producer.update_attributes(params[:producer])
        flash[:notice] = 'Wydawca został zapisany poprawnie.'
        format.html { redirect_to([:admin, @producer]) }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @producer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /producers/1
  # DELETE /producers/1.xml
  def destroy
    @producer = Producer.find(params[:id])
    @producer.destroy

    if @producer.destroyed?
      flash[:notice] = 'Wydawca został usunięty poprawnie.'
    else
      flash[:notice] = 'Wystąpił błąd podczas usuwania wydawcy.'
    end


    respond_to do |format|
      format.html { redirect_to(admin_producers_url) }
      format.xml { head :ok }
    end
  end
end

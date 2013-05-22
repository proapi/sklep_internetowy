# encoding: utf-8

class Admin::EntriesController < ApplicationController

  layout "admin"

  before_filter :require_user

  autocomplete :entry, :title, :full => true

  # GET /entries
  # GET /entries.xml
  def index
    if params[:entry]
      @search = Entry.search :title_like => params[:entry][:title]
      params.clear
    else
      @search = Entry.search(params[:search])
    end

    @entries = @search.paginate(:per_page => "20", :page => params[:page])

    redirect_to admin_entry_path(@entries.first, params) and return if (@entries.size.eql?(1))

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @entries }
    end
  end

  # GET /entries/site
  # GET /entries/site.xml
  def site
    if params[:title]
      @entry = Entry.find_by_title(params[:title])
    end

    unless @entry
      redirect_to root_url and return
    end

    respond_to do |format|
      format.html # site.html.erb
      format.xml { render :xml => @entry }
    end
  end

  # GET /entries/1
  # GET /entries/1.xml
  def show
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @entry }
    end
  end

  # GET /entries/new
  # GET /entries/new.xml
  def new
    @entry = Entry.new
    @categories = Category.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @entry }
    end
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
    @categories = Category.all
  end

  # POST /entries
  # POST /entries.xml
  def create
    @entry = Entry.new(params[:entry])

    respond_to do |format|
      if @entry.save
        format.html { redirect_to([:admin, @entry], :notice => 'Strona została zapisana poprawnie.') }
        format.xml { render :xml => @entry, :status => :created, :location => @entry }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.xml
  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        format.html { redirect_to([:admin, @entry], :notice => 'Strona została zapisana poprawnie.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @entry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.xml
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    flash[:notice] = "Strona została usunięta poprawnie" if @entry.destroyed?

    respond_to do |format|
      format.html { redirect_to(admin_entries_url) }
      format.xml { head :ok }
    end
  end
end

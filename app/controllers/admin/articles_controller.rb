# encoding: utf-8

class Admin::ArticlesController < ApplicationController

  layout "admin"

  before_filter :require_user

  autocomplete :article, :title, :full => true

  # GET /articles
  # GET /articles.xml
  def index
    if params[:article]
      @search = Article.search :title_like => params[:article][:title]
      params.clear
    else
      @search = Article.search(params[:search])
    end

    @articles = @search.paginate(:per_page => "20", :page => params[:page])

    redirect_to [:admin, @articles.first] and return if (@articles.size.eql?(1))

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new
    @article.photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
    @article.build_photo unless @article.photo
  end

  # POST /articles
  # POST /articles.xml
  def create
    @article = Article.new(params[:article])

    respond_to do |format|
      if @article.save
        format.html { redirect_to([:admin, @article], :notice => 'Artykuł został zapisany poprawnie.') }
        format.xml { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to([:admin, @article], :notice => 'Artykuł został zapisany poprawnie.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    flash[:notice] = "Artykuł został usunięty poprawnie." if @article.destroyed?

    respond_to do |format|
      format.html { redirect_to(admin_articles_url) }
      format.xml { head :ok }
    end
  end
end

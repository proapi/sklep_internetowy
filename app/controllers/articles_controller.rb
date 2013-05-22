# encoding: utf-8

class ArticlesController < ApplicationController

  layout "application"

  # GET /articles
  # GET /articles.xml
  def index
    @search = Article.where("ready is true").search(params[:search])
    @articles = @search.paginate(:per_page => 9, :page => params[:page])


    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.find(params[:id])

    #na tą chwilę musi tak zostać, ma to związek z wywołaniem javascriptowym z listy artykółów, którego nie można przystosować do friendly_id
    if !@article.nil? && (request.path != article_path(@article))
      redirect_to @article, status: :moved_permanently and return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @article }
    end
  end

end

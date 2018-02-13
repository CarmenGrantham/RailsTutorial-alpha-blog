class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    
    #Show what has been entered in the form
    #render plain: params[:article].inspect
    
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was successfully created"
      
      # Redirect to show template
      redirect_to article_path(@article)
    else
      # There were errors so reshow article
      render 'new'
    end
  end

  def update
    
    #Show what has been entered in the form
    #render plain: params[:article].inspect
    
    @article = Article.find(params[:id])
    
    #Update article with values from parameters
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated"
      
      # Redirect to show template
      redirect_to article_path(@article)
    else
      # There were errors so reshow article
      render 'edit'
    end
  end
  
  def show
    # the :id comes from the parameter in the url
    @article = Article.find(params[:id])
  end
    
  def edit
    @article = Article.find(params[:id])
  end
  
  def index
    @articles = Article.all
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    
    flash[:notice] = "Article has been successfully deleted"
    redirect_to articles_path
  end
    
  private
    def article_params
      # White list values
      params.require(:article).permit(:title, :description)
    end
  
  
end

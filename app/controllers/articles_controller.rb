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

  def show
    # the :id comes from the parameter in the url
    @article = Article.find(params[:id])
  
  end
  
  private
    def article_params
      # White list values
      params.require(:article).permit(:title, :description)
    end
  
  
end

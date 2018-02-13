class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    
    #Show what has been entered in the form
    #render plain: params[:article].inspect
    
    @article = Article.new(article_params)
    @article.save
    
    # Redirect to show template
    redirect_to articles_show(@article)
  end
  
  private
    def article_params
      # White list values
      params.require(:article).permit(:title, :description)
    end
  
  
end

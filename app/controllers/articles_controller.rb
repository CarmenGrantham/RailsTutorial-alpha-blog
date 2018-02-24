class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :show, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def new
    @article = Article.new
  end

  def create
    
    #Show what has been entered in the form
    #render plain: params[:article].inspect
    
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:success] = "Article was successfully created"
      
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
    
    
    #Update article with values from parameters
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      
      # Redirect to show template
      redirect_to article_path(@article)
    else
      # There were errors so reshow article
      render 'edit'
    end
  end
  
  def show
    
  end
    
  def edit
    
  end
  
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def destroy
    
    @article.destroy
    
    flash[:danger] = "Article has been successfully deleted"
    redirect_to articles_path
  end
    
  private
  def article_params
    # White list values
    params.require(:article).permit(:title, :description)
  end

  def set_article
    # the :id comes from the parameter in the url
    @article = Article.find(params[:id])
  end

  def require_same_user
    if current_user != @article.user
      flash[:danger] = "You can only edit or delete your own articles"
      redirect_to root_path
    end
  end
end

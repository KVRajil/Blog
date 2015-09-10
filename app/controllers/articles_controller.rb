class ArticlesController < ApplicationController
  def index
      if current_user
        @articles = Article.paginate(:page => params[:page], :per_page => 3)
      else
        redirect_to root_url
      end
  end
  def show
    if current_user
      @article = Article.find(params[:id])
      @user = User.find(@article.user_id)
    else
      redirect_to root_url
    end
  end

  def new
    if current_user
      @article = Article.new
    else
      redirect_to root_url
    end
  end
  def edit
    @article = Article.find(params[:id])
    if current_user && @article.user_id == current_user.id
      render 'edit'
    else
      render :file => 'public/422.html'
    end
  end
  def create
    if current_user
      @article = Article.new(article_params)
      @article.user_id = current_user.id

      if @article.save
        redirect_to @article
      else
        render 'new'
      end
    else
      redirect_to root_url
    end
  end

  def update
  @article = Article.find(params[:id])

  if @article.update(article_params)
    redirect_to @article
  else
    render 'edit'
  end
 end
 def destroy
   @article = Article.find(params[:id])
   if current_user && @article.user_id == current_user.id
     @article = Article.find(params[:id])
     @article.destroy
     redirect_to articles_path
  else
     render :file => 'public/422.html'
  end

end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
  end

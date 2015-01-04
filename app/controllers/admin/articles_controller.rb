class Admin::ArticlesController < AdminsController
  def index
    @articles = Article.includes(:section).all.sort_by(&:updated_at).reverse
  end

  def new
    @section = Section.find(params[:admin_section_id])
    @article = Article.new
  end

  def create
    @section = Section.find(params[:admin_section_id])
    @article = Article.new params.require(:article).permit(:title, :body, :section_id, :excerpt, :hero_image)

    if @article.save
      redirect_to admin_section_path(@section)
    else
      render 'new'
    end
  end

  def edit
    @section  = Section.find(params[:admin_section_id])
    @sections = Section.all
    @article  = Article.find(params[:id])
  end

  def update
    @section = Section.find(params[:admin_section_id])
    @article = Article.find(params[:id])

    if @article.update_attributes params.require(:article).permit(:title, :body, :excerpt, :hero_image)
      redirect_to admin_section_path(@section)
    else
      @sections = Section.all
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])

    if @article.destroy
      redirect_to admin_articles_path
    end
  end
end
class Admin::SectionsController < AdminsController
  def index
    @sections = Section.all.sort_by(&:updated_at).reverse
  end

  def new
    @section = Section.new
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])

    if @section.update_attributes params.require(:section).permit(:title)
      redirect_to admin_sections_path
    else
      render 'edit'
    end
  end

  def show
    @section = Section.find(params[:id])
    @articles = @section.articles
  end

  def destroy
    @section = Section.find(params[:id])

    if @section.destroy
      redirect_to admin_sections_path
    end
  end

  def create
    @section = Section.new params.require(:section).permit(:title)

    if @section.save
      redirect_to admin_sections_path
    else
      render 'new'
    end
  end
end
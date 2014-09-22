class Admin::GuidelinesController < AdminsController
  def index
    @guidelines = Guideline.all.reverse
  end

  def new
    @guideline = Guideline.new
  end

  def create
    @guideline = Guideline.new guideline_params

    if @guideline.save
      redirect_to guidelines_path
    else
      render 'new'
    end
  end

  def destroy
    @guideline = Guideline.find(params[:id])

    if @guideline.destroy
      redirect_to guidelines_path
    end
  end

  private

  def guideline_params
    params.require(:guideline).permit(:name)
  end
end
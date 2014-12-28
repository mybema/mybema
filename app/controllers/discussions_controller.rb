class DiscussionsController < ApplicationController
  before_action :fetch_categories, only: [:show, :index, :edit, :new]

  def index
    if slug = params[:category]
      @category = DiscussionCategory.where(slug: slug).first
      @discussions = Discussion.where(discussion_category: @category).with_includes.visible.by_recency
    else
      @discussions = Discussion.with_includes.visible.by_recency
    end
  end

  def new
    unless @current_user.can_contribute? || current_admin
      return redirect_to new_user_registration_path
    end

    @discussion = Discussion.new
    @guidelines = Guideline.all.reverse
  end

  def edit
    @discussion = @current_user.discussions.find_by_id(params[:id])
    @guidelines = Guideline.all.reverse

    unless @discussion && editable_discussion
      flash[:alert] = "You don't have permission to do that"
      return redirect_to discussions_path
    end
  end

  def create
    @discussion = Discussion.new discussion_params

    unless @current_user.can_contribute? || current_admin
      return redirect_to new_user_registration_path
    end

    if @discussion.save
      create_identicon('Discussion', @discussion.id)
      flash[:notice] = 'Your discussion has been added'
      redirect_to discussion_path(@discussion.slug)
    else
      @categories = DiscussionCategory.all
      @guidelines = Guideline.all.reverse
      flash[:alert] = 'Your discussion could not be created'
      render 'new'
    end
  end

  def show
    @discussion = Discussion.find_by_slug(params[:slug]) || not_found
    @admin_id   = current_admin.id if current_admin
    @comment    = DiscussionComment.new
    @comments   = @discussion.discussion_comments.sort_by(&:created_at)

    if @discussion.hidden? && @admin_id == nil
      flash[:alert] = 'This discussion is not available anymore'
      redirect_to discussions_path
    end
  end

  def update
    @discussion = @current_user.discussions.where(id: params[:id]).first

    unless @discussion
      flash[:alert] = 'You cannot do that'
      return redirect_to discussions_path
    end

    if editable_discussion
      if @discussion.update_attributes(discussion_params)
        flash[:notice] = 'Your discussion has been updated'
        redirect_to discussion_path(@discussion.slug)
      else
        flash[:alert] = 'This discussion could not be updated'
        @guidelines = Guideline.all.reverse
        @categories = DiscussionCategory.all
        render 'edit'
      end
    else
      flash[:alert] = 'You cannot do that'
      return redirect_to discussions_path
    end
  end

  private

  def fetch_categories
    @categories = DiscussionCategory.all
  end

  def discussion_params
    params.require(:discussion).permit(:body, :title, :admin_id, :user_id, :discussion_category_id, :guest_id, :humanizer_answer, :humanizer_question_id)
  end

  def editable_discussion
    @current_user.logged_in? || (@discussion.guest_id == cookies.permanent[:mybema_guest_id] && @current_user.can_contribute?)
  end
end
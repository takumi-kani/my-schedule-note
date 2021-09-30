class CommentsController < ApplicationController
  def create
    @schedule = Schedule.find(params[:schedule_id])
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to schedule_path(@comment.schedule)
    else
      @schedule = @comment.schedule
      @comments = @schedule.comments
      render 'schedules/show'
    end
  end

  private

  def comment_params
    if user_signed_in?
      params.require(:comment).permit(:text).merge(user_id: current_user.id, schedule_id: params[:schedule_id])
    else
      params.require(:comment).permit(:text).merge(admin_id: current_admin.id, schedule_id: params[:schedule_id])
    end
  end
end

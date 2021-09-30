class SchedulesController < ApplicationController
  def index
    @schedules = Schedule.all
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      redirect_to root_path(@schedule)
    else
      render new_schedule_path
    end
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  private

  def schedule_params
    if user_signed_in?
      params.require(:schedule).permit(:title, :start_time, :end_time, :place, :info).merge(user_id: current_user.id)
    else
      params.require(:schedule).permit(:title, :start_time, :end_time, :place, :info).merge(admin_id: current_admin.id)
    end
  end
end

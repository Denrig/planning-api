# frozen_string_literal: true

class Api::V1::TasksController < Api::V1::BaseController
  def index
    render json: room.tasks
  end

  def create
    task = Tasks::CreationService.call(
      params: task_params,
      room: room
    ).task

    render json: task
  end

  def update
    Tasks::UpdateService.call(
      params: task_params,
      task: room.tasks.find(params[:id])
    ).task

    head :ok
  end

  def show
    task = Jira::Tasks::ConvertionService.call(id: params[:id]).task

    render json: task
  end

  def destroy
    room.tasks.destroy_all
    room.broadcast({ type: :TASKS_CLEARED })

    head :ok
  end

  private

    def task_params
      params.permit(:text, :result, :is_current, :description, :status, :issue_type, :jira_id)
    end

    def room
      @room = Room.active.find(params[:room_id])
    end
end

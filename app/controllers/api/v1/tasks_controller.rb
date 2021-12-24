# frozen_string_literal: true

class Api::V1::TasksController < Api::V1::BaseController
  def index
    render json: room.tasks
  end

  def create
    task = room.tasks.create(task_params)
    SocketTypesHandler.call(room: room, content: { type: :TASK_ADDED, task: task })

    render json: task
  end

  private

    def task_params
      params.permit(:text)
    end

    def room
      @room = Room.active.find(params[:room_id])
    end
end
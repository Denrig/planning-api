# frozen_string_literal: true

class Api::V1::TasksController < Api::V1::BaseController
  def index
    render json: room.tasks
  end

  def create
    task = room.tasks.create(task_params.merge(is_current: true))
    room.broadcast({ type: :TASK_ADDED,
                     task: TaskSerializer.new(task).serializable_hash })

    render json: task
  end

  def update
    task = room.tasks.find(params[:id])
    task.update!(task_params)

    room.broadcast({
                     type: :TASK_UPDATED,
                     task: TaskSerializer.new(task).serializable_hash.except(:votes)
                   })

    head :ok
  end

  private

    def task_params
      params.permit(:text, :result, :is_current)
    end

    def room
      @room = Room.active.find(params[:room_id])
    end
end

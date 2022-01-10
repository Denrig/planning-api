# frozen_string_literal: true

class Api::V1::VotesController < Api::V1::BaseController
  def create
    vote = Vote.find_by(user_id: vote_params[:user_id], task_id: vote_params[:task_id])

    if vote
      vote.update!(vote: vote_params[:vote])
    else
      vote = Vote.create!(vote_params)
    end

    vote.room.broadcast({
                          type: :PLAYER_VOTED,
                          vote: { user_id: vote.user_id, vote: vote.vote }
                        })

    head :ok
  end

  def destroy
    vote = Vote.find_by(user_id: vote_params[:user_id], task_id: vote_params[:task_id])

    if vote
      vote.destroy!
      vote.room.broadcast({
                            type: :PLAYER_VOTE_CANCELED,
                            user_id: vote.user_id
                          })
    end

    head :ok
  end

  def update
    task = Task.find(params[:id])
    data = {
      type: :DISPLAY_VOTES_CHANGED,
      value: params[:value]
    }
    data[:results] = task.voting_results if params[:value]
    task.votes.destroy_all unless params[:value]

    task.room.broadcast(data)
  end

  private

    def vote_params
      params.permit(:user_id, :task_id, :vote)
    end
end

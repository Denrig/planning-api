# frozen_string_literal: true

class VoteSerializer < ActiveModel::Serializer
  attributes :vote, :user_id
end

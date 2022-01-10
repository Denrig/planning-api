# frozen_string_literal: true

class TaskSerializer < ActiveModel::Serializer
  attributes :id, :result, :text

  has_many :votes
end

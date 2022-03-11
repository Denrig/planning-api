# frozen_string_literal: true

class TaskSerializer < ActiveModel::Serializer
  attributes :id, :result, :text, :is_current

  has_many :votes
end

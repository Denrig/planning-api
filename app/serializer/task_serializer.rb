# frozen_string_literal: true

class TaskSerializer < ActiveModel::Serializer
  attributes :id, :result, :text, :is_current, :description, :issue_type, :status

  has_many :votes
end

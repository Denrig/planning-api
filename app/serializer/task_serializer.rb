# frozen_string_literal: true

class TaskSerializer < ActiveModel::Serializer
  attributes :id, :is_current, :text
end

# frozen_string_literal: true

# == Schema Information
#
# Table name: rooms
#
#  id            :uuid             not null, primary key
#  name          :string
#  players_count :integer
#  active        :boolean          default(TRUE)
#  is_private    :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  code          :string
#  jira_key      :string
#
class Room < ApplicationRecord
  has_many :room_attendances, dependent: :destroy
  has_many :users, through: :room_attendances

  has_many :players, lambda {
                       where(room_attendances: { role: :player }).distinct
                     }, through: :room_attendances, class_name: 'User', source: :user

  has_many :tasks, dependent: :destroy

  validates :name, presence: true
  validates :jira_key, uniqueness: true, allow_blank: true

  scope :active, -> { where(active: true) }

  before_create :set_code

  def create_admin!(user_id)
    room_attendances.create!(user_id: user_id, role: :admin)
  end

  def set_code
    self.code = SecureRandom.hex(3)
  end

  def broadcast(data)
    RoomChannel.broadcast_to(self, data)
  end
end

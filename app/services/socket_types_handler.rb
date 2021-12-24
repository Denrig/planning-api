class SocketTypesHandler < BaseService
  parameters :room, :content

  def call
    room.broadcast(content)
  end
end

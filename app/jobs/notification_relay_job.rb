class NotificationRelayJob < ApplicationJob
  queue_as :default

  def perform(video)
    User.online.each do |user|
      ActionCable.server.broadcast("notifications:#{user.id}", {
        video_title: video[:title],
        created_by: video[:created_by],
      })
    end
  end
end
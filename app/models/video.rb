class Video < ApplicationRecord
  after_create_commit { NotificationRelayJob.perform_later(self.as_json(index: true)) }

  belongs_to :user, required: true

  def as_json(options = {})
    if options[:index]
      {
        id: id,
        video_id: video_id,
        video_url: video_url,
        title: title,
        description: description,
        thumbnail: thumbnail,
        embed_url: embed_url,
        embed_code: embed_code,
        views_total: views_total,
        likes_total: likes_total,
        created_at: created_at,
        user_id: user_id,
        created_by: user.email
      }
    else
      super
    end
  end
end
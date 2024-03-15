class Api::V1::VideoController < ActionController::API
  include CurrentUserConcern

  def index
    videos = Video.includes(:user).all.order(created_at: :desc).as_json(index: true)

    render json: {
      videos: videos
    }
  end

  def info
    isUrlValid = VideoInfo.valid_url?(params["video_url"])
    if !isUrlValid
      render json: { status: 500}
    end

    video = VideoInfo.new(params["video_url"])
    if !video
      render json: { status: 500}
    end

    newVideo = Video.create!(
      video_id: video.video_id,
      video_url: params["video_url"],
      title: video.title,
      description: video.description,
      thumbnail: video.thumbnail_large,
      embed_url: video.embed_url,
      embed_code: video.embed_code,
      views_total: video.stats['viewCount'],
      likes_total: video.stats['likeCount'],
      user_id: @current_user.id
    )

    if !newVideo
      render json: { status: 500}
    end

    render json: {
      status: :success,
      video: newVideo
    }

  end
end

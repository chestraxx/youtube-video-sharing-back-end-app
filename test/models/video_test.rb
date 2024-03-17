require "test_helper"

class VideoTest < ActiveSupport::TestCase
  test "get video should return video instance" do
    video = Video.last

    assert_instance_of Video, video
  end

  test "get video as_json must return Hash with value" do
    video = Video.last.as_json()

    assert_instance_of Hash, video
    assert_not video["created_by"]
  end

  test "get video as_json(index: true) must return Hash with value re-mapped" do
    video = Video.last.as_json(index: true)

    assert_instance_of Hash, video
    assert video[:created_by]
    assert_equal video[:created_by], "Guest"
  end

  test "should not save video without params" do
    video = Video.new

    assert_not video.save, "saved video without params"
  end

  test "should not save video without video_id" do
    video = Video.new(
      video_url: "video_url",
      title: "title",
      description: "description",
      thumbnail: "thumbnail_large",
      embed_url: "embed_url",
      embed_code: "embed_code",
      views_total: 0,
      likes_total: 0,
      user_id: 1
    )

    assert_not video.save, "saved video without video_id"
  end

  test "should not save video without video_url" do
    video = Video.new(
      video_id: 1,
      title: "title",
      description: "description",
      thumbnail: "thumbnail_large",
      embed_url: "embed_url",
      embed_code: "embed_code",
      views_total: 0,
      likes_total: 0,
      user_id: 1
    )

    assert_not video.save, "saved video without video_url"
  end

  test "should not save video without title" do
    video = Video.new(
      video_id: 1,
      video_url: "video_url",
      description: "description",
      thumbnail: "thumbnail_large",
      embed_url: "embed_url",
      embed_code: "embed_code",
      views_total: 0,
      likes_total: 0,
      user_id: 1
    )

    assert_not video.save, "saved video without title"
  end

  test "should not save video with user that not exist" do
    video = Video.new(
      video_id: 1,
      video_url: "video_url",
      title: "title",
      description: "description",
      thumbnail: "thumbnail_large",
      embed_url: "embed_url",
      embed_code: "embed_code",
      views_total: 0,
      likes_total: 0,
      user_id: 1
    )

    assert_not video.save, "saved video with user that not exist"
  end

  test "should save video with user that is exist" do
    user = User.create(
      email: "test@gmail.com",
      password: "123456"
    )

    video = Video.new(
      video_id: 1,
      video_url: "video_url",
      title: "title",
      description: "description",
      thumbnail: "thumbnail_large",
      embed_url: "embed_url",
      embed_code: "embed_code",
      views_total: 0,
      likes_total: 0,
      user_id: user.id
    )

    assert video.save, "saved with user that is exist"
  end
end

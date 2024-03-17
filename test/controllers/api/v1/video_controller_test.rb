require "test_helper"

class VideoControllerTest < ActionDispatch::IntegrationTest
  user = { email: 'test_email@gmail.com', password: '123456' }
  youtube_link = "https://www.youtube.com/watch?v=FBM70NaZuVI&list=RDFBM70NaZuVI&index=1"
  docs_link = "https://docs.google.com/document/d/12yXceZ-QbZj0hZJqV9ngKEwaKMa3p5YqdswA3lKQZyE"

  test "api_v1_videos_url must work" do
    get api_v1_videos_url

    body = ActiveSupport::JSON.decode(@response.body)
    assert_response :success
    assert_instance_of Hash, ActiveSupport::JSON.decode(@response.body)
    assert_instance_of Array, body["videos"]
    assert body["videos"][0]["id"]
  end

  test "api_v1_video_info must not work when user is not login" do
    post api_v1_video_info_url, params: { video_url: youtube_link}

    body = ActiveSupport::JSON.decode(@response.body)
    assert_response :success
    assert_equal body["status"], 500
  end

  test "api_v1_video_info must not work when user is login and link is invalid" do
    post api_v1_sessions_url, params: { user: user}

    post api_v1_video_info_url, params: { video_url: docs_link}

    body = ActiveSupport::JSON.decode(@response.body)
    assert_response :success
    assert_equal body["status"], 500
  end

  test "api_v1_video_info must work when user is login and link is valid" do
    post api_v1_sessions_url, params: { user: user}

    post api_v1_video_info_url, params: { video_url: youtube_link}

    body = ActiveSupport::JSON.decode(@response.body)
    assert_response :success
    assert_equal body["status"], "success"
    assert_equal body["video"]["video_url"], youtube_link
    assert body["video"]["id"]
    assert body["video"]["video_id"]
  end
end

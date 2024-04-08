require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  user_login = { email: 'test_email@gmail.com', password: '123456' }
  user_login2 = { email: 'test_email2@gmail.com', password: '123456' }

  test "api_v1_sessions must work" do
    post api_v1_sessions_url, params: { user: user_login}

    user = User.where(email: 'test_email@gmail.com').first

    body = ActiveSupport::JSON.decode(@response.body)
    assert_response :success
    assert_equal body["status"], "created"
    assert_equal body["logged_in"], true
    assert_equal user.email, body["user"]["email"]
    assert_equal user.password_digest, body["user"]["password_digest"]
    assert_equal user.id, session[:user_id]
  end

  test "api_v1_sessions will create new user if not exist" do
    post api_v1_sessions_url, params: { user: user_login2}

    user = User.where(email: 'test_email2@gmail.com').first

    body = ActiveSupport::JSON.decode(@response.body)
    assert_response :success
    assert_equal body["status"], "created"
    assert_equal body["registed"], true
    assert_equal user.email, body["user"]["email"]
    assert_equal user.password_digest, body["user"]["password_digest"]
    assert_equal user.id, session[:user_id]
  end

  test "api_v1_logged_in must work" do
    post api_v1_sessions_url, params: { user: user_login}

    get api_v1_logged_in_url

    body = ActiveSupport::JSON.decode(@response.body)
    assert_response :success
    assert_equal body["logged_in"], true
    assert_equal body["user"]["id"], session[:user_id]
  end

  test "api_v1_logout must work" do
    post api_v1_sessions_url, params: { user: user_login}

    delete api_v1_logout_url

    body = ActiveSupport::JSON.decode(@response.body)
    assert_response :success
    assert_equal body["status"], "deleted"
    assert_equal body["logged_out"], true
    assert_nil session[:user_id]
  end
end

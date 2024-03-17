require "test_helper"

class RegistrationControllerTest < ActionDispatch::IntegrationTest
  test "api_v1_registration_index must work" do
    post api_v1_registration_index_url, params: { user: { email: 'test_email2@gmail.com', password: '123456' }}

    body = ActiveSupport::JSON.decode(@response.body)
    assert_response :success
    assert_equal body["status"], "created"
    assert_equal "test_email2@gmail.com", body["user"]["email"]
    assert_equal session[:user_id], body["user"]["id"]
  end
end

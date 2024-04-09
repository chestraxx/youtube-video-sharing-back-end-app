require "test_helper"

class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
  test "connects with cookies" do
    user = User.last

    cookies.signed[:user_id] = user.id

    connect params: { user_id: user.id }

    assert_equal connection.current_user.id, user.id
  end

  test "connects without cookies" do
    assert_reject_connection { connect params: { user_id: 12345678 } }
  end
end

require "test_helper"

class NotificationsChannelTest < ActionCable::Channel::TestCase
  test "subscribes" do
    user = User.last

    stub_connection current_user: user

    subscribe
    assert subscription.confirmed?
  end
end

require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without params" do
    user = User.new

    assert_not user.save, "saved user without params"
  end

  test "should not save user without email" do
    user = User.new(
      email: "",
      password: "123456"
    )

    assert_not user.save, "saved user without email"
  end

  test "should not save user without password" do
    user = User.new(
      email: "test@gmail.com",
      password: ""
    )

    assert_not user.save, "saved user without password"
  end

  test "should not save user with email already existed" do
    assert User.create(
      email: "test@gmail.com",
      password: "123456"
    )
    assert user = User.new(
      email: "test@gmail.com",
      password: "123456"
    )
    assert user.invalid?
    assert user.errors.include?(:email)

    # puts user.errors.full_messages
  end

  test "should not save user with email that format is not correct" do
    assert user = User.new(
      email: "test@gmail",
      password: "123456"
    )
    assert user.invalid?
    assert user.errors.include?(:email)

    # puts user.errors.full_messages
  end

  test "should save user with unique email and password" do
    assert user = User.new(
      email: "test@gmail.com",
      password: "123456"
    )

    assert user.save
  end
end

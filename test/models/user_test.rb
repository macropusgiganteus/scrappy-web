require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:david)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = ""
    assert_not @user.valid?
    assert_includes @user.errors[:username], "can't be blank"
  end

  test "password_digest should be present" do 
    @user.password_digest = ""
    assert_not @user.valid?
    assert_includes @user.errors[:password_digest], "can't be blank"
  end
end

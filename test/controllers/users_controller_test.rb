require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get register_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { username: 'john', password: 'test1', password_confirmation: 'test1' } }
    end

    assert_redirected_to login_url
    assert_equal "User created successfully", flash[:notice]
  end

  test "should not create a user if params are empty" do
    assert_no_difference('User.count') do
      post users_url, params: { user: { username: '', password: '', password_confirmation: '' } }
    end

    assert_response :unprocessable_entity
    assert_equal "User not created", flash[:alert]
  end

  test "should not create a user if password_confirmation is invalid" do
    assert_no_difference('User.count') do
      post users_url, params: { user: { username: 'john', password: 'test1', password_confirmation: 'test2' } }
    end

    assert_response :unprocessable_entity
    assert_equal "User not created", flash[:alert]
  end

  test "should not create a user when username already existed" do
    assert_no_difference('User.count') do
      post users_url, params: { user: { username: 'david', password: 'test', password_confirmation: 'test' } }
    end

    assert_response :unprocessable_entity
    assert_equal "User not created", flash[:alert]
  end
end

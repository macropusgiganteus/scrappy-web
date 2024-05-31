require "test_helper"

class UserSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:david)
  end
  
  test "should get new" do
    get login_url
    assert_response :success
  end

  test "should set user in session on login" do
    # Action
    post user_sessions_url, params: { user: { username: @user.username, password: 'test'} }
    
    # Assert
    assert_equal @user.id, session[:user_id]
    assert_redirected_to root_path
  end

  test "should not set a user session if credentials are invalid" do
    # Action
    post user_sessions_url, params: { user: { username: @user.username, password: 'invalidpwd'} }
    
    # Assert
    assert_nil session[:user_id]
    assert_redirected_to login_url
    assert_equal "Login failed", flash[:alert]
  end

  test "should not set a user session if credentials are empty" do
    # Action
    post user_sessions_url, params: { user: { username: "", password: ""} }
    
    # Assert
    assert_nil session[:user_id]
    assert_redirected_to login_url
    assert_equal "Login failed", flash[:alert]
  end

  test "should destroy a user session" do
    # Arrange
    login()
    assert_equal @user.id, session[:user_id]

    # Action
    delete user_session_url(@user.id)
    
    # Assert
    assert_nil session[:user_id]
    assert_redirected_to root_path
  end
end

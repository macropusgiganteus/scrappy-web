require "test_helper"

class KeywordsControllerTest < ActionDispatch::IntegrationTest
    test "should redirect to login page when not logged in" do
        get keywords_url
        assert_redirected_to login_url, message: "You must be logged in to access this section"
    end

    test "should get index when logged in" do
        login()

        get keywords_url
        assert_response :success
        
    end
end
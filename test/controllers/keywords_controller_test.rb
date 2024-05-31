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

    test "user can see keywords list" do
        # Arrange
        login()

        # Action
        get keywords_url
        assert_response :success

        # Assert
        html = Nokogiri::HTML(response.body)
        tbody = html.at_css('tbody')
        row_count = tbody.css('tr').size
        assert_equal 5, row_count
    end

    test "user can filter keywords" do
        # Arrange
        login()

        # Action
        get keywords_url, params: { query: 'keyword2'}
        assert_response :success

        # Assert
        html = Nokogiri::HTML(response.body)
        tbody = html.at_css('tbody')
        row_count = tbody.css('tr').size
        assert_equal 3, row_count
    end

    test "user can upload csv file" do
    end

    test "fire search google when csv file is uploaded" do
    end
end
require "test_helper"

class KeywordTest < ActiveSupport::TestCase
  def setup
    @keyword = keywords(:one)
  end

  test "should be valid" do
    assert @keyword.valid?
  end

  test "keyword should be present" do
    @keyword.keyword = ""
    assert_not @keyword.valid?
    assert_includes @keyword.errors[:keyword], "can't be blank"
  end

  test "should belong to a user" do
    assert_respond_to @keyword, :user
  end

  test "should have one keyword result" do 
    assert_respond_to @keyword, :keyword_result
  end
end

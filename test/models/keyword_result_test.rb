require "test_helper"

class KeywordResultTest < ActiveSupport::TestCase
  def setup
    @keyword_result = keyword_results(:one)
  end

  test "should be valid" do
    assert @keyword_result.valid?
  end

  test "total_ads should be present" do 
    @keyword_result.total_ads = nil
    assert_not @keyword_result.valid?
    assert_includes @keyword_result.errors[:total_ads], "can't be blank"
  end

  test "total_links should be present" do 
    @keyword_result.total_links = nil
    assert_not @keyword_result.valid?
    assert_includes @keyword_result.errors[:total_links], "can't be blank"
  end

  test "total_search_results should be present" do 
    @keyword_result.total_search_results = nil
    assert_not @keyword_result.valid?
    assert_includes @keyword_result.errors[:total_search_results], "can't be blank"
  end

  test "html should be present" do 
    @keyword_result.html = nil
    assert_not @keyword_result.valid?
    assert_includes @keyword_result.errors[:html], "can't be blank"
  end

  test "should belong to a keyword" do
    assert_respond_to @keyword_result, :keyword
  end
end

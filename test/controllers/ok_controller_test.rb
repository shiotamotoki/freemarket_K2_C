require 'test_helper'

class OkControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ok_index_url
    assert_response :success
  end

end

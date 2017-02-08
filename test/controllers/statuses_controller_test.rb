require 'test_helper'

class StatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @status = statuses(:one)
  end

  test "should get index" do
    get statuses_url
    assert_response :success
    assert_select 'title', "Changelog"
  end

  test "should get new" do
    get new_status_url
    assert_response :success
  end

  test "should create status" do
    assert_difference('Status.count') do
      post statuses_url, params: { status: { object_id: @status.object_id, object_type: @status.object_type, state: @status.state, timestamp: @status.timestamp } }
    end

    assert_redirected_to status_url(Status.last)
  end

  test "should show status" do
    get status_url(@status)
    assert_response :success
  end

  test "should get edit" do
    get edit_status_url(@status)
    assert_response :success
  end

  test "should update status" do
    patch status_url(@status), params: { status: { object_id: @status.object_id, object_type: @status.object_type, state: @status.state, timestamp: @status.timestamp } }
    assert_redirected_to status_url(@status)
  end

  test "should upload status data file" do
    assert_difference('Status.count', 7) do
      post "/statuses/upload_csv_file", params: { csv_file: fixture_file_upload('data.csv', 'text/plain') }
    end
  end

  test "should destroy status" do
    assert_difference('Status.count', -1) do
      delete status_url(@status)
    end

    assert_redirected_to statuses_url
  end
end

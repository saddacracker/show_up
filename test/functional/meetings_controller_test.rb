require 'test_helper'

class MeetingsControllerTest < ActionController::TestCase
  setup do
    @meeting = meetings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:meetings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create meeting" do
    assert_difference('Meeting.count') do
      post :create, meeting: { address: @meeting.address, closed_meeting: @meeting.closed_meeting, days_of_week: @meeting.days_of_week, description: @meeting.description, duration: @meeting.duration, latitude: @meeting.latitude, longitude: @meeting.longitude, tags: @meeting.tags, time: @meeting.time, title: @meeting.title }
    end

    assert_redirected_to meeting_path(assigns(:meeting))
  end

  test "should show meeting" do
    get :show, id: @meeting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @meeting
    assert_response :success
  end

  test "should update meeting" do
    put :update, id: @meeting, meeting: { address: @meeting.address, closed_meeting: @meeting.closed_meeting, days_of_week: @meeting.days_of_week, description: @meeting.description, duration: @meeting.duration, latitude: @meeting.latitude, longitude: @meeting.longitude, tags: @meeting.tags, time: @meeting.time, title: @meeting.title }
    assert_redirected_to meeting_path(assigns(:meeting))
  end

  test "should destroy meeting" do
    assert_difference('Meeting.count', -1) do
      delete :destroy, id: @meeting
    end

    assert_redirected_to meetings_path
  end
end

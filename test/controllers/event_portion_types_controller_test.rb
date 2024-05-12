require "test_helper"

class EventPortionTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event_portion_type = event_portion_types(:one)
  end

  test "should get index" do
    get event_portion_types_url
    assert_response :success
  end

  test "should get new" do
    get new_event_portion_type_url
    assert_response :success
  end

  test "should create event_portion_type" do
    assert_difference("EventPortionType.count") do
      post event_portion_types_url, params: { event_portion_type: {} }
    end

    assert_redirected_to event_portion_type_url(EventPortionType.last)
  end

  test "should show event_portion_type" do
    get event_portion_type_url(@event_portion_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_portion_type_url(@event_portion_type)
    assert_response :success
  end

  test "should update event_portion_type" do
    patch event_portion_type_url(@event_portion_type), params: { event_portion_type: {} }
    assert_redirected_to event_portion_type_url(@event_portion_type)
  end

  test "should destroy event_portion_type" do
    assert_difference("EventPortionType.count", -1) do
      delete event_portion_type_url(@event_portion_type)
    end

    assert_redirected_to event_portion_types_url
  end
end

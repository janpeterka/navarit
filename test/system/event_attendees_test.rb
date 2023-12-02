require "application_system_test_case"

class EventAttendeesTest < ApplicationSystemTestCase
  setup do
    @event_attendee = event_attendees(:one)
  end

  test "visiting the index" do
    visit event_attendees_url
    assert_selector "h1", text: "Event attendees"
  end

  test "should create event attendee" do
    visit event_attendees_url
    click_on "New event attendee"

    click_on "Create Event attendee"

    assert_text "Event attendee was successfully created"
    click_on "Back"
  end

  test "should update Event attendee" do
    visit event_attendee_url(@event_attendee)
    click_on "Edit this event attendee", match: :first

    click_on "Update Event attendee"

    assert_text "Event attendee was successfully updated"
    click_on "Back"
  end

  test "should destroy Event attendee" do
    visit event_attendee_url(@event_attendee)
    click_on "Destroy this event attendee", match: :first

    assert_text "Event attendee was successfully destroyed"
  end
end

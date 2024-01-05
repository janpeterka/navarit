require "application_system_test_case"

class EventPortionTypesTest < ApplicationSystemTestCase
  setup do
    @event_portion_type = event_portion_types(:one)
  end

  test "visiting the index" do
    visit event_portion_types_url
    assert_selector "h1", text: "Event portion types"
  end

  test "should create event portion type" do
    visit event_portion_types_url
    click_on "New event portion type"

    click_on "Create Event portion type"

    assert_text "Event portion type was successfully created"
    click_on "Back"
  end

  test "should update Event portion type" do
    visit event_portion_type_url(@event_portion_type)
    click_on "Edit this event portion type", match: :first

    click_on "Update Event portion type"

    assert_text "Event portion type was successfully updated"
    click_on "Back"
  end

  test "should destroy Event portion type" do
    visit event_portion_type_url(@event_portion_type)
    click_on "Destroy this event portion type", match: :first

    assert_text "Event portion type was successfully destroyed"
  end
end

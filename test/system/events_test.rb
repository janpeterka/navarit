# frozen_string_literal: true

require "application_system_test_case"

class EventsTest < ApplicationSystemTestCase
  test "visiting the index" do
    @event = FactoryBot.create(:event, name: "Awesome event", author: current_user)

    visit events_url
    assert_selector "h2", text: "NADCHÁZEJÍCÍ AKCE"
    assert_selector "a", text: "Awesome event"
  end

  test "showing dialog with day details" do
    FactoryBot.create(:shopping, author: current_user)
    @event = FactoryBot.create(:event, author: current_user, name: "Amazing event",
                                       date_from: Date.new(2024, 1, 1), date_to: Date.new(2024, 1, 7))

    visit event_url(@event)
    assert_text "Amazing event"

    click_link "Pondělí 01.01."

    within "dialog" do # (1) Modal opens
      within "#new_daily_plan_task" do
        fill_in "název", with: "Úkol na tento den"
        click_button "přidat"
      end
      # assert_text "Úkol na tento den" # (2) Still in the modal

      send_keys :escape
    end

    assert_no_selector "dialog" # (3) Modal closes on success
    # assert_text "User was successfully created." # Flash message
  end
end

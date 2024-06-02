# frozen_string_literal: true

require "application_system_test_case"

class EventsTest < ApplicationSystemTestCase
  test "visiting the index" do
    @event = FactoryBot.create(:event, author: current_user)

    visit events_url
    assert_selector "h2", text: "NADCHÁZEJÍCÍ AKCE"
    assert_selector "a", text: "Random event"
  end
end

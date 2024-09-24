require "test_helper"

class ArchivedEventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in @current_user
  end

  test "cannot archive others events" do
    event = FactoryBot.create(:event, author: FactoryBot.create(:user))

    post archived_events_url(event_id: event.id)

    event.reload

    assert_equal false, event.archived?
  end

  test "cannot archive others events with viewer role" do
    event = FactoryBot.create(:event, author: FactoryBot.create(:user))
    event.add_collaborator(@current_user, permission: :viewer)

    post archived_events_url(event_id: event.id)

    event.reload

    assert_equal false, event.archived?
  end

  test "can archive own events" do
    event = FactoryBot.create(:event, author: @current_user)

    post archived_events_url(event_id: event.id)

    event.reload

    assert event.archived?
  end

  test "can archive events with collaborator role" do
    event = FactoryBot.create(:event, author: FactoryBot.create(:user))
    event.add_collaborator(@current_user, permission: :collaborator)

    post archived_events_url(event_id: event.id)

    event.reload

    assert event.archived?
  end
end

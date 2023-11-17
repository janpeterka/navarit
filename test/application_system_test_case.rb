# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  setup do
    Current.user = User.find_by(id: 1) || FactoryBot.create(:user)
  end

  teardown do
    Current.user = nil
  end
end

# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

  setup do
    current_user = User.find_by(id: 1) || FactoryBot.create(:user)
  end

  teardown do
    current_user = nil
  end
end

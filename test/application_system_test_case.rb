# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

  setup do
    sign_in User.find_by(id: 1) || FactoryBot.create(:user)
  end

  teardown do
    sign_out :user
  end
end

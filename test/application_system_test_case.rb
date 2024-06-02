# frozen_string_literal: true

require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]

  setup do
    @current_user = User.find_by(id: 1) || FactoryBot.create(:user)
    sign_in @current_user
  end

  teardown do
    sign_out :user
  end

  def current_user
    @current_user
  end
end

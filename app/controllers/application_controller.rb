# frozen_string_literal: true

class ApplicationController < PublicApplicationController
  include Pagy::Backend

  before_action :authenticate_user!
end

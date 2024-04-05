# frozen_string_literal: true

class PublicApplicationController < ActionController::Base
  include Pagy::Backend

  layout 'application'
end

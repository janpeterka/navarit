# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "Honza <obr@skaut.cz>"
  layout "mailer"
end

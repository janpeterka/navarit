require "feedback/version"
require "feedback/engine"

module Feedback
  # Creator is used to reference the user who created the feedback post, comment, or who is the recipient of the notification.
  mattr_accessor :creator_class

  self.creator_class = "User"
end

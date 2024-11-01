require "feedback/version"
require "feedback/engine"

module Feedback
  # Creator is used to reference the user who created the feedback post, comment, or who is the recipient of the notification.
  mattr_accessor :creator_class
  mattr_accessor :creator_foreign_key
  mattr_accessor :synchronization_backend
  mattr_accessor :notifiable_admin_ids
  mattr_accessor :notifiable_admins

  def self.creator_class = "User"

  def self.creator_foreign_key
    "#{creator_class.underscore}_id".to_sym
  end

  def self.synchronization_backend
    # Options:
    # nil: No synchronization, just application database
    # :github: Synchronize with GitHub (needs GitHub API token)
    # :gitlab: Synchronize with GitLab (needs GitLab API token)
    nil
  end

  def self.notifiable_admin_ids = [ 1 ]

  def self.notifiable_admins
    self.creator_class.constantize.where(id: self.notifiable_admin_ids)
  end

  # def self.synchronization_backend_connector
end

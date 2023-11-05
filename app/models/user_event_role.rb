# frozen_string_literal: true

class UserEventRole < ApplicationRecord
  self.table_name = 'users_have_event_roles'

  belongs_to :user
  belongs_to :event

  validates :role, presence: true, uniqueness: { scope: %i[user_id event_id] },
                   inclusion: { in: %w[collaborator viewer] }
end

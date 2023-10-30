class UserEventRole < ActiveRecord
  table_name "users_have_event_roles"
  belongs_to :user
  belongs_to :event

  validates :role, presence: true, uniqueness: { scope: [:user_id, :event_id] },
                   inclusion: { in: %w[collaborator viewer] }
end

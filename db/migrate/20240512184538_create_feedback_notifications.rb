class CreateFeedbackNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :feedback_notifications do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true, type: :integer
      t.datetime :read_at
      t.references :notifiable, polymorphic: true, null: false

      t.timestamps
    end
  end
end

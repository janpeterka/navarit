class CreateFeedbackModels < ActiveRecord::Migration[7.1]
  def change
    create_table :feedback_posts do |t|
      t.text :description
      t.references :user, null: false
      # t.datetime :last_synchronized_at
      t.integer :status
      # t.integer :issue_id
      # t.string :issue_url

      t.timestamps
    end

    create_table :feedback_comments do |t|
      t.text :content
      t.references :post, null: false
      t.references :user
      # t.datetime :last_synchronized_at
      # t.integer :comment_id
      # t.string :comment_url

      t.timestamps
    end

    create_table :feedback_notifications do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true, type: :integer
      t.datetime :read_at
      t.references :notifiable, polymorphic: true, null: false

      t.timestamps
    end
  end
end

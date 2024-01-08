class CreateFeedbackPost < ActiveRecord::Migration[7.1]
  def change
    create_table :feedback_posts do |t|
      t.text :description
      t.references :user, null: false
      t.datetime :last_synchronized_at
      t.integer :status
      t.integer :issue_id
      t.string :issue_url

      t.timestamps
    end
  end
end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_05_12_184538) do
  create_table "action_text_rich_texts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "body", size: :long
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "alembic_version", primary_key: "version_num", id: { type: :string, limit: 32 }, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
  end

  create_table "attendees", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "event_id", null: false
    t.string "name", null: false
    t.integer "portion_type_id"
    t.text "note"
    t.index ["event_id"], name: "ix_attendees_event_id"
    t.index ["portion_type_id"], name: "fk_attendees_portion_type_id_portion_types"
  end

  create_table "attendees_have_labels", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "attendee_id", null: false
    t.integer "label_id", null: false
    t.index ["attendee_id"], name: "ix_attendees_have_labels_attendee_id"
    t.index ["label_id"], name: "ix_attendees_have_labels_label_id"
  end

  create_table "daily_plan_tasks", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "daily_plan_id", null: false
    t.index ["daily_plan_id"], name: "fk_daily_plan_tasks_daily_plan_id_daily_plans"
  end

  create_table "daily_plans", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.date "date", null: false
    t.integer "created_by", null: false
    t.integer "event_id"
    t.index ["created_by"], name: "ix_daily_plans_created_by"
    t.index ["event_id"], name: "fk_dailyplans_events"
  end

  create_table "daily_plans_have_recipes", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "daily_plan_id", null: false
    t.integer "position"
    t.datetime "created_at", precision: nil
    t.column "meal_type", "enum('snídaně','dopolední svačina','oběd','odpolední svačina','večeře','programové','jiné','nákup')"
    t.float "portion_count", null: false
    t.index ["daily_plan_id"], name: "ix_daily_plans_have_recipes_daily_plan_id"
    t.index ["recipe_id"], name: "ix_daily_plans_have_recipes_recipe_id"
  end

  create_table "event_has_portion_type", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "count", null: false
    t.integer "event_id", null: false
    t.integer "portion_type_id", null: false
    t.index ["event_id"], name: "fk_event_has_portion_type_events_id_events"
    t.index ["portion_type_id"], name: "fk_event_has_portion_type_portion_type_id_portion_types"
  end

  create_table "events", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "created_by", null: false
    t.string "name", limit: 80
    t.date "date_from"
    t.date "date_to"
    t.integer "people_count"
    t.boolean "is_archived"
    t.boolean "is_shared"
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil
    t.integer "updated_by"
    t.index ["created_by"], name: "ix_events_created_by"
    t.index ["updated_by"], name: "fk_events_updated_by_users"
  end

  create_table "feedback_comments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "content"
    t.bigint "post_id", null: false
    t.bigint "user_id"
    t.datetime "last_synchronized_at"
    t.integer "comment_id"
    t.string "comment_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_feedback_comments_on_post_id"
    t.index ["user_id"], name: "index_feedback_comments_on_user_id"
  end

  create_table "feedback_notifications", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.integer "user_id", null: false
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_feedback_notifications_on_user_id"
  end

  create_table "feedback_posts", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "last_synchronized_at"
    t.integer "status"
    t.integer "issue_id"
    t.string "issue_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_feedback_posts_on_user_id"
  end

  create_table "files", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "extension", null: false
    t.string "path", null: false
    t.string "hash", null: false
    t.datetime "created_at", precision: nil, null: false
    t.integer "user_id"
    t.integer "recipe_id"
    t.integer "created_by", null: false
    t.string "file_type", limit: 40
    t.boolean "is_main"
    t.index ["created_by"], name: "ix_files_created_by"
    t.index ["recipe_id"], name: "recipe_id"
    t.index ["user_id"], name: "user_id"
  end

  create_table "flask_dance_oauth", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "provider", limit: 50, null: false
    t.datetime "created_at", precision: nil, null: false
    t.text "token", size: :long, null: false, collation: "utf8mb4_bin"
    t.string "provider_user_id", limit: 256, null: false
    t.integer "user_id", null: false
    t.index ["provider_user_id"], name: "uq_flask_dance_oauth_provider_user_id", unique: true
    t.index ["user_id"], name: "fk_flask_dance_oauth_user_id_users"
    t.check_constraint "json_valid(`token`)", name: "flask_dance_oauth_chk_1"
  end

  create_table "ingredient_categories", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", limit: 80
    t.string "description"
    t.boolean "is_lasting"
    t.index ["name"], name: "uq_ingredient_categories_name", unique: true
  end

  create_table "ingredients", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "created_by", null: false
    t.datetime "created_at", precision: nil, null: false
    t.text "description"
    t.integer "measurement_id"
    t.float "calorie", default: 0.0
    t.float "sugar", default: 0.0
    t.float "fat", default: 0.0
    t.float "protein", default: 0.0
    t.integer "category_id"
    t.boolean "is_public"
    t.string "source"
    t.datetime "updated_at", precision: nil
    t.integer "updated_by"
    t.index ["category_id"], name: "fk_ingredient_category"
    t.index ["created_by"], name: "ix_ingredients_created_by"
    t.index ["measurement_id"], name: "measurement_id"
    t.index ["updated_by"], name: "fk_ingredients_updated_by_users"
  end

  create_table "label_categories", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", limit: 80
    t.string "description"
    t.boolean "allow_multiple"
    t.index ["name"], name: "uq_label_categories_name", unique: true
  end

  create_table "labels", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", limit: 80
    t.string "visible_name", limit: 80
    t.string "description"
    t.integer "category_id"
    t.string "color"
    t.index ["category_id"], name: "category_id"
    t.index ["name"], name: "uq_labels_name", unique: true
    t.index ["visible_name"], name: "uq_labels_visible_name", unique: true
  end

  create_table "measurements", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", limit: 80, null: false
    t.string "description"
    t.string "suffix", limit: 20
    t.string "thousand_fold", limit: 20
    t.integer "sorting_priority", default: 0
    t.index ["name"], name: "uq_measurements_name", unique: true
  end

  create_table "measurements_to_measurements", primary_key: ["ingredient_id", "to_measurement_id"], charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "ingredient_id", null: false
    t.integer "to_measurement_id", null: false
    t.float "amount_from"
    t.float "amount_to"
    t.index ["to_measurement_id"], name: "to_measurement_id"
  end

  create_table "portion_types", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.float "size", null: false
    t.integer "created_by", null: false
    t.index ["created_by"], name: "ix_portion_types_created_by"
  end

  create_table "recipe_categories", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", limit: 80
    t.string "description"
    t.index ["name"], name: "uq_recipe_categories_name", unique: true
  end

  create_table "recipe_tasks", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "days_before_cooking"
    t.integer "recipe_id", null: false
    t.index ["recipe_id"], name: "fk_recipe_tasks_recipe_id_recipes"
  end

  create_table "recipes", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "created_by", null: false
    t.datetime "created_at", precision: nil
    t.datetime "last_updated_at", precision: nil
    t.text "description", size: :long
    t.boolean "is_shared"
    t.integer "category_id"
    t.boolean "is_hidden"
    t.integer "portion_count"
    t.index ["category_id"], name: "category_id"
    t.index ["created_by"], name: "ix_recipes_created_by"
  end

  create_table "recipes_have_ingredients", primary_key: ["recipe_id", "ingredient_id"], charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.integer "ingredient_id", null: false
    t.float "amount"
    t.string "comment"
    t.index ["ingredient_id"], name: "ix_recipes_have_ingredients_ingredient_id"
    t.index ["recipe_id"], name: "ix_recipes_have_ingredients_recipe_id"
  end

  create_table "recipes_have_labels", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.integer "recipe_id", null: false
    t.integer "label_id", null: false
    t.index ["label_id"], name: "label_id"
    t.index ["recipe_id"], name: "recipe_id"
  end

  create_table "request_logs", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "url"
    t.string "remote_addr"
    t.float "duration"
    t.string "item_type"
    t.integer "item_id"
    t.integer "user_id"
    t.index ["user_id"], name: "ix_request_logs_user_id"
  end

  create_table "roles", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", limit: 80
    t.string "description"
    t.text "permissions"
    t.datetime "update_datetime", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["name"], name: "uq_roles_name", unique: true
  end

  create_table "tips", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.integer "created_by", null: false
    t.text "description", null: false
    t.boolean "is_approved", null: false
    t.boolean "is_hidden", null: false
    t.index ["created_by"], name: "ix_tips_created_by"
  end

  create_table "users", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "email", null: false
    t.string "password"
    t.boolean "active", null: false
    t.string "fs_uniquifier", limit: 64, null: false
    t.datetime "confirmed_at", precision: nil
    t.datetime "last_login_at", precision: nil
    t.datetime "current_login_at", precision: nil
    t.string "last_login_ip", limit: 64
    t.string "current_login_ip", limit: 64
    t.integer "login_count"
    t.string "tf_primary_method", limit: 64
    t.string "tf_totp_secret"
    t.string "tf_phone_number", limit: 128
    t.datetime "create_datetime", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "update_datetime", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "username"
    t.text "us_totp_secrets"
    t.string "us_phone_number", limit: 128
    t.datetime "created_at", precision: nil
    t.string "full_name"
    t.string "calendar_hash"
    t.string "fs_webauthn_user_handle", limit: 64
    t.text "mf_recovery_codes"
    t.string "encrypted_password", default: "", null: false
    t.string "legacy_password", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "locked_at"
    t.index ["calendar_hash"], name: "uq_users_calendar_hash", unique: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["email"], name: "uq_users_email", unique: true
    t.index ["fs_uniquifier"], name: "uq_users_fs_uniquifier", unique: true
    t.index ["fs_webauthn_user_handle"], name: "uq_users_fs_webauthn_user_handle", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["us_phone_number"], name: "uq_users_us_phone_number", unique: true
    t.index ["username"], name: "uq_users_username", unique: true
  end

  create_table "users_have_event_roles", primary_key: ["event_id", "user_id"], charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "user_id", null: false
    t.column "role", "enum('collaborator','viewer')"
    t.index ["event_id"], name: "ix_users_have_event_roles_event_id"
    t.index ["user_id"], name: "ix_users_have_event_roles_user_id"
  end

  create_table "users_have_recipes_reaction", id: :integer, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.integer "recipe_id", null: false
    t.integer "user_id", null: false
    t.index ["recipe_id"], name: "ix_users_have_recipes_reaction_recipe_id"
    t.index ["user_id"], name: "ix_users_have_recipes_reaction_user_id"
  end

  create_table "users_have_roles", id: false, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "role_id"
    t.index ["user_id"], name: "user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "attendees", "events", name: "fk_attendees_event_id_events"
  add_foreign_key "attendees", "portion_types", name: "fk_attendees_portion_type_id_portion_types"
  add_foreign_key "attendees_have_labels", "attendees", name: "fk_attendees_have_labels_attendee_id_attendees"
  add_foreign_key "attendees_have_labels", "labels", name: "fk_attendees_have_labels_label_id_labels"
  add_foreign_key "daily_plan_tasks", "daily_plans", name: "fk_daily_plan_tasks_daily_plan_id_daily_plans"
  add_foreign_key "daily_plans", "events", name: "fk_dailyplans_events"
  add_foreign_key "daily_plans", "users", column: "created_by", name: "daily_plans_ibfk_1"
  add_foreign_key "daily_plans_have_recipes", "daily_plans", name: "daily_plans_have_recipes_ibfk_1"
  add_foreign_key "daily_plans_have_recipes", "recipes", name: "daily_plans_have_recipes_ibfk_2"
  add_foreign_key "event_has_portion_type", "events", name: "fk_event_has_portion_type_events_id_events"
  add_foreign_key "event_has_portion_type", "portion_types", name: "fk_event_has_portion_type_portion_type_id_portion_types"
  add_foreign_key "events", "users", column: "created_by", name: "events_ibfk_1"
  add_foreign_key "events", "users", column: "updated_by", name: "fk_events_updated_by_users"
  add_foreign_key "feedback_notifications", "users"
  add_foreign_key "files", "recipes", name: "files_ibfk_2"
  add_foreign_key "files", "users", column: "created_by", name: "files_ibfk_1"
  add_foreign_key "files", "users", name: "files_ibfk_3"
  add_foreign_key "flask_dance_oauth", "users", name: "fk_flask_dance_oauth_user_id_users"
  add_foreign_key "ingredients", "ingredient_categories", column: "category_id", name: "fk_ingredient_category"
  add_foreign_key "ingredients", "measurements", name: "ingredients_ibfk_2"
  add_foreign_key "ingredients", "users", column: "created_by", name: "ingredients_ibfk_1"
  add_foreign_key "ingredients", "users", column: "updated_by", name: "fk_ingredients_updated_by_users"
  add_foreign_key "labels", "label_categories", column: "category_id", name: "labels_ibfk_1"
  add_foreign_key "measurements_to_measurements", "ingredients", name: "measurements_to_measurements_ibfk_1"
  add_foreign_key "measurements_to_measurements", "measurements", column: "to_measurement_id", name: "measurements_to_measurements_ibfk_2"
  add_foreign_key "portion_types", "users", column: "created_by", name: "fk_portion_types_created_by_users"
  add_foreign_key "recipe_tasks", "recipes", name: "fk_recipe_tasks_recipe_id_recipes"
  add_foreign_key "recipes", "recipe_categories", column: "category_id", name: "recipes_ibfk_2"
  add_foreign_key "recipes", "users", column: "created_by", name: "recipes_ibfk_1"
  add_foreign_key "recipes_have_ingredients", "ingredients", name: "recipes_have_ingredients_ibfk_1"
  add_foreign_key "recipes_have_ingredients", "recipes", name: "recipes_have_ingredients_ibfk_2"
  add_foreign_key "recipes_have_labels", "labels", name: "recipes_have_labels_ibfk_1"
  add_foreign_key "recipes_have_labels", "recipes", name: "recipes_have_labels_ibfk_2"
  add_foreign_key "request_logs", "users", name: "request_logs_ibfk_1"
  add_foreign_key "tips", "users", column: "created_by", name: "tips_ibfk_1"
  add_foreign_key "users_have_event_roles", "events", name: "fk_users_have_event_roles_event_id_events"
  add_foreign_key "users_have_event_roles", "users", name: "fk_users_have_event_roles_user_id_users"
  add_foreign_key "users_have_recipes_reaction", "recipes", name: "users_have_recipes_reaction_ibfk_1"
  add_foreign_key "users_have_recipes_reaction", "users", name: "users_have_recipes_reaction_ibfk_2"
  add_foreign_key "users_have_roles", "roles", name: "users_have_roles_ibfk_1"
  add_foreign_key "users_have_roles", "users", name: "users_have_roles_ibfk_2"
end

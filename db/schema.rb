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

ActiveRecord::Schema[7.0].define(version: 2022_05_29_144712) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activity_logs", force: :cascade do |t|
    t.string "loggable_type", null: false
    t.bigint "loggable_id", null: false
    t.bigint "user_id", null: false
    t.bigint "user_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_group_id"], name: "index_activity_logs_on_user_group_id"
    t.index ["user_id"], name: "index_activity_logs_on_user_id"
  end

  create_table "repetitive_task_logs", force: :cascade do |t|
    t.date "date", null: false
    t.bigint "repetitive_task_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repetitive_task_id"], name: "index_repetitive_task_logs_on_repetitive_task_id"
  end

  create_table "repetitive_tasks", force: :cascade do |t|
    t.string "name", null: false
    t.integer "interval_days", null: false
    t.bigint "user_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_group_id"], name: "index_repetitive_tasks_on_user_group_id"
  end

  create_table "task_create_logs", force: :cascade do |t|
    t.bigint "repetitive_task_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repetitive_task_id"], name: "index_task_create_logs_on_repetitive_task_id"
  end

  create_table "task_done_logs", force: :cascade do |t|
    t.bigint "repetitive_task_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repetitive_task_id"], name: "index_task_done_logs_on_repetitive_task_id"
  end

  create_table "user_groups", force: :cascade do |t|
    t.bigint "owner_id"
    t.string "invitation_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invitation_code"], name: "index_user_groups_on_invitation_code", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.bigint "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_token", null: false
    t.index ["group_id"], name: "index_users_on_group_id"
  end

  add_foreign_key "activity_logs", "user_groups"
  add_foreign_key "activity_logs", "users"
  add_foreign_key "repetitive_task_logs", "repetitive_tasks"
  add_foreign_key "repetitive_tasks", "user_groups"
  add_foreign_key "task_create_logs", "repetitive_tasks"
  add_foreign_key "task_done_logs", "repetitive_tasks"
  add_foreign_key "users", "user_groups", column: "group_id"
end

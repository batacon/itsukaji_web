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

ActiveRecord::Schema[7.0].define(version: 2022_04_05_135338) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_repetitive_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "image", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "repetitive_task_logs", "repetitive_tasks"
  add_foreign_key "repetitive_tasks", "users"
end

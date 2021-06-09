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

ActiveRecord::Schema.define(version: 2021_06_09_062824) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "downloaders", force: :cascade do |t|
    t.string "ftp_path"
    t.boolean "rename"
    t.string "rename_prefix"
    t.integer "setting_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "interval"
    t.boolean "processing_status"
    t.index ["setting_id"], name: "index_downloaders_on_setting_id"
  end

  create_table "file_listings", force: :cascade do |t|
    t.string "file_name"
    t.string "file_path"
    t.datetime "last_modified"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "settings", force: :cascade do |t|
    t.string "instance_name"
    t.string "ftp_server"
    t.integer "ftp_port"
    t.string "ftp_password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
  end

  add_foreign_key "downloaders", "settings"
end

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

ActiveRecord::Schema[7.2].define(version: 2024_11_24_132014) do
  create_table "commodities", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.string "introduction"
    t.integer "business_id"
    t.string "homepage"
    t.boolean "exist"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deals", force: :cascade do |t|
    t.integer "seller"
    t.integer "customer"
    t.datetime "date"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "commodity"
  end

  create_table "messages", force: :cascade do |t|
    t.datetime "date"
    t.string "content"
    t.integer "publisher"
    t.integer "acceptor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "avator"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end

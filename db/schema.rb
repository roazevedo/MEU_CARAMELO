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

ActiveRecord::Schema[7.1].define(version: 2024_02_24_174014) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adoption_forms", force: :cascade do |t|
    t.string "query"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_adoption_forms_on_user_id"
  end

  create_table "adoptions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "animal_id", null: false
    t.datetime "date", precision: nil
    t.boolean "done"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_adoptions_on_animal_id"
    t.index ["user_id"], name: "index_adoptions_on_user_id"
  end

  create_table "animals", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.string "size"
    t.string "gender"
    t.boolean "vaccination"
    t.boolean "neutered"
    t.string "story"
    t.string "city"
    t.string "specie"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_animals_on_user_id"
  end

  create_table "testimonies", force: :cascade do |t|
    t.bigint "adoption_id", null: false
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["adoption_id"], name: "index_testimonies_on_adoption_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "phone"
    t.string "city"
    t.string "state"
    t.integer "age"
    t.string "size"
    t.string "gender"
    t.boolean "vaccination"
    t.boolean "neutered"
    t.string "specie"
    t.boolean "adopter"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "adoption_forms", "users"
  add_foreign_key "adoptions", "animals"
  add_foreign_key "adoptions", "users"
  add_foreign_key "animals", "users"
  add_foreign_key "testimonies", "adoptions"
end

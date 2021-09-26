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

ActiveRecord::Schema.define(version: 2021_09_25_214321) do

  create_table "pokemons", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "type_onw"
    t.string "type_two"
    t.decimal "total", precision: 10
    t.decimal "hp", precision: 10
    t.decimal "attack", precision: 10
    t.decimal "defense", precision: 10
    t.decimal "sp_atk", precision: 10
    t.decimal "sp_def", precision: 10
    t.decimal "speed", precision: 10
    t.decimal "generation", precision: 10
    t.boolean "legendary"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end

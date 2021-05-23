# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "block_effects", force: :cascade do |t|
    t.integer "move_id"
    t.integer "move_effect_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.string "wiki_link"
    t.string "full_image_link"
    t.string "thumb_image_link"
    t.string "fighting_style"
    t.string "archetype"
    t.string "difficulty"
    t.string "tier"
    t.string "publish"
    t.text "gameplay"
    t.text "strengths"
    t.text "weaknesses"
    t.string "movement"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "counter_hit_effects", force: :cascade do |t|
    t.integer "move_id"
    t.integer "move_effect_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "fan_arts", force: :cascade do |t|
    t.string "link"
    t.string "artist_name"
    t.string "artist_link"
    t.string "art_type"
    t.string "style"
    t.string "is_main"
    t.string "description"
    t.integer "character_id"
    t.integer "profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "followups", force: :cascade do |t|
    t.integer "preceding_move_id"
    t.integer "followup_move_id"
    t.boolean "is_guaranteed"
    t.integer "hit_status"
    t.string "explanation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hit_effects", force: :cascade do |t|
    t.integer "move_id"
    t.integer "move_effect_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "inputs", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.boolean "is_direction"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "move_effects", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.text "desc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "move_extensions", force: :cascade do |t|
    t.integer "extension_id"
    t.integer "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "move_properties", force: :cascade do |t|
    t.integer "move_id"
    t.integer "property_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "move_purposes", force: :cascade do |t|
    t.integer "move_id"
    t.integer "purpose_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "moves", force: :cascade do |t|
    t.string "name"
    t.string "input"
    t.string "cancel_input"
    t.string "startup"
    t.string "on_block"
    t.string "on_hit"
    t.string "on_counter_hit"
    t.string "hit_damage"
    t.string "conter_hit_damage"
    t.string "hit_level"
    t.string "type"
    t.text "counter"
    t.text "explaination"
    t.integer "character_id"
    t.bigint "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "stance_id"
    t.index ["parent_id"], name: "index_moves_on_parent_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "details"
    t.string "post_type"
    t.integer "character_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string "nickname"
    t.boolean "isadmin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "icon_link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "purposes", force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stances", force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.integer "character_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transition_stances", force: :cascade do |t|
    t.integer "move_id"
    t.integer "stance_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end

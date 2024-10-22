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

ActiveRecord::Schema[7.2].define(version: 2024_10_18_200716) do
  create_table "attentions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "register_in_id"
    t.integer "register_out_id"
    t.index ["register_in_id"], name: "index_attentions_on_register_in_id"
    t.index ["register_out_id"], name: "index_attentions_on_register_out_id"
  end

  create_table "protocols", force: :cascade do |t|
    t.string "title"
  end

  create_table "register_ins", force: :cascade do |t|
    t.integer "fatigue"
    t.integer "pain"
    t.integer "general"
    t.datetime "created_at", null: false
    t.integer "attention_id"
    t.index ["attention_id"], name: "index_register_ins_on_attention_id"
  end

  create_table "register_outs", force: :cascade do |t|
    t.integer "fatigue"
    t.integer "pain"
    t.integer "general"
    t.datetime "created_at", null: false
    t.integer "attention_id"
    t.integer "protocol_id"
    t.index ["attention_id"], name: "index_register_outs_on_attention_id"
    t.index ["protocol_id"], name: "index_register_outs_on_protocol_id"
  end
end

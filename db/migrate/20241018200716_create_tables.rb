class CreateTables < ActiveRecord::Migration[7.2]
  def change
    create_table :attentions, id: false do |t|
      t.integer "id", primary_key: true
      t.datetime "created_at", null: false
      t.references :register_ins, foreign_key: true
      t.references :register_outs, foreign_key: true
    end

    create_table :register_ins, id: false do |t|
      t.integer "id", primary_key: true
      t.integer "fatigue"
      t.integer "pain"
      t.integer "general"
      t.datetime "created_at", null: false
    end

    create_table :register_outs, id: false do |t|
      t.integer "id", primary_key: true
      t.integer "fatigue"
      t.integer "pain"
      t.integer "general"
      t.datetime "created_at", null: false
      t.references :protocol, foreign_key: true
    end

    create_table :protocols, id: false do |t|
      t.integer "id", primary_key: true
      t.string "title"
    end
  end
end

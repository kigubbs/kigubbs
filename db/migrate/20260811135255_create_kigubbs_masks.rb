# frozen_string_literal: true

class CreateKigubbsMasks < ActiveRecord::Migration[8.0]
  def change
    create_table :kigubbs_masks, id: false do |t|
      t.string :id, limit: 26, null: false, primary_key: true

      t.references :owner_user,
                   null: false,
                   foreign_key: { to_table: :users },
                   index: true

      t.string :name, null: false
      t.string :character_name, null: false
      t.string :maker_name

      t.date :delivered_on
      t.date :debuted_on

      t.text :description

      t.timestamps
    end
  end
end

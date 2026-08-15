# frozen_string_literal: true

class CreateKigubbsMasks < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!
  def change
    create_table :kigubbs_masks, id: false do |t|
      t.string :id, limit: 26, null: false, primary_key: true
      t.bigint :owner_user_id, null: false
      t.string :name, null: false
      t.string :character_name, null: false
      t.string :maker_name

      t.date :delivered_on
      t.date :debuted_on

      t.text :description

      t.timestamps
    end
    index_name = "index_kigubbs_masks_on_owner_user_id"
    remove_index :kigubbs_masks, name: index_name, if_exists: true
    add_index :kigubbs_masks, :owner_user_id, name: index_name, algorithm: :concurrently
    add_foreign_key :kigubbs_masks, :users, column: :owner_user_id
  end
end

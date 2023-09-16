# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.uuid :uuid, default: 'gen_random_uuid()', null: false

      t.integer :score
      t.text :note
      t.boolean :note_has_spoilers, null: false
      t.boolean :favorite, null: false

      t.timestamps
    end
  end
end

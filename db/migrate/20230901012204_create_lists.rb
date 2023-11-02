# frozen_string_literal: true

class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|
      t.uuid :uuid, default: 'gen_random_uuid()', null: false

      t.string :title, null: false
      t.string :list_type, null: false

      t.timestamps
    end
  end
end

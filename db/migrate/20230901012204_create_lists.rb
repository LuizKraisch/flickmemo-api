# frozen_string_literal: true

class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|
      t.uuid :uuid, default: 'uuid_generate_v4()', null: false

      t.string :type, null: false

      t.timestamps
    end
  end
end

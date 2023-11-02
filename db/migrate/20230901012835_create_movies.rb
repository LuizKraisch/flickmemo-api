# frozen_string_literal: true

class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.uuid :uuid, default: 'gen_random_uuid()', null: false

      t.string :external_id, null: false
      t.string :title, null: false
      t.string :poster_path

      t.timestamps
    end
  end
end

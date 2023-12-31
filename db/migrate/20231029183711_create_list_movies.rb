# frozen_string_literal: true

class CreateListMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :list_movies do |t|
      t.references :list, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end

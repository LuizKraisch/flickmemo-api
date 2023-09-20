# frozen_string_literal: true

class CreateListsMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :lists_movies, id: false do |t|
      t.references :list, foreign_key: true
      t.references :movie, foreign_key: true
    end

    add_index :lists_movies, %i[list_id movie_id], unique: true
  end
end

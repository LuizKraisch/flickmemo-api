# frozen_string_literal: true

class AddForeignKeys < ActiveRecord::Migration[7.0]
  def change
    add_column :api_tokens, :user_id, :integer
    add_column :users, :api_token_id, :integer

    add_column :lists, :user_id, :integer

    add_column :reviews, :user_id, :integer
    add_column :reviews, :movie_id, :integer

    add_column :movies, :list_id, :integer

    add_foreign_key :api_tokens, :users, column: :user_id
    add_foreign_key :users, :api_tokens, column: :api_token_id

    add_foreign_key :lists, :users, column: :user_id

    add_foreign_key :reviews, :users, column: :user_id
    add_foreign_key :reviews, :movies, column: :movie_id

    add_foreign_key :movies, :lists, column: :list_id
  end
end

# frozen_string_literal: true

class CreateApiTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :api_tokens do |t|
      t.boolean :active, presence: true
      t.text :token, null: false, unique: true

      t.timestamps
    end
  end
end

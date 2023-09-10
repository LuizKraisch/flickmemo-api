# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.uuid :uuid, default: 'gen_random_uuid()', null: false

      t.string :google_user_uid, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :photo_url

      t.timestamps
    end
  end
end

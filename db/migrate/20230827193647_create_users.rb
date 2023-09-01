class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.uuid :uuid, default: "uuid_generate_v4()", null: false

      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :bio
      t.string :google_id_token, null: false

      t.timestamps
    end
  end
end

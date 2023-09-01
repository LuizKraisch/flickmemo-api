class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.uuid :uuid, default: "uuid_generate_v4()", null: false

      t.string :movie_external_id
      t.integer :score
      t.text :note
      t.boolean :note_has_spoilers
      t.boolean :favorite

      t.timestamps
    end
  end
end

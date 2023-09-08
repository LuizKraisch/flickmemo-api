# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_901_012_835) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'
  enable_extension 'uuid-ossp'

  create_table 'api_tokens', force: :cascade do |t|
    t.uuid 'uuid', default: -> { 'uuid_generate_v4()' }, null: false
    t.boolean 'active'
    t.text 'token', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'lists', force: :cascade do |t|
    t.uuid 'uuid', default: -> { 'uuid_generate_v4()' }, null: false
    t.string 'type', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'movies', force: :cascade do |t|
    t.uuid 'uuid', default: -> { 'uuid_generate_v4()' }, null: false
    t.string 'movie_external_id', null: false
    t.integer 'score'
    t.text 'note'
    t.boolean 'note_has_spoilers', null: false
    t.boolean 'favorite', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.uuid 'uuid', default: -> { 'uuid_generate_v4()' }, null: false
    t.string 'google_user_uid', null: false
    t.string 'first_name', null: false
    t.string 'last_name', null: false
    t.string 'email', null: false
    t.string 'photo_url'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end

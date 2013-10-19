# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131019033552) do

  create_table "publication_sections", force: true do |t|
    t.integer "publication_id"
    t.string  "name"
    t.string  "url"
  end

  add_index "publication_sections", ["publication_id", "name"], name: "index_publication_sections_on_publication_id_and_name", unique: true
  add_index "publication_sections", ["publication_id"], name: "index_publication_sections_on_publication_id"

  create_table "publications", force: true do |t|
    t.string   "name"
    t.string   "logo_url"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publications", ["slug"], name: "index_publications_on_slug", unique: true

  create_table "screenshots", force: true do |t|
    t.integer  "publication_section_id"
    t.integer  "timestamp",              default: 0
    t.string   "image_uid"
    t.string   "image_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "screenshots", ["publication_section_id"], name: "index_screenshots_on_publication_section_id"
  add_index "screenshots", ["timestamp", "publication_section_id"], name: "index_screenshots_on_timestamp_and_publication_section_id", unique: true

end

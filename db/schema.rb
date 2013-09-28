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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130824193515) do

  create_table "games", :force => true do |t|
    t.integer  "p1_score",   :default => 0
    t.boolean  "player1",    :default => true
    t.integer  "p2_score",   :default => 0
    t.boolean  "player2",    :default => false
    t.integer  "dice1"
    t.integer  "dice2"
    t.integer  "dice3"
    t.integer  "dice4"
    t.integer  "dice5"
    t.integer  "dice6"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "D1_held",    :default => false
    t.boolean  "D2_held",    :default => false
    t.boolean  "D3_held",    :default => false
    t.boolean  "D4_held",    :default => false
    t.boolean  "D5_held",    :default => false
    t.boolean  "D6_held",    :default => false
    t.integer  "temp_score", :default => 0
  end

end

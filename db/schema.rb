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

ActiveRecord::Schema[7.2].define(version: 2024_12_08_043610) do
  create_table "answers", force: :cascade do |t|
    t.integer "quiz_id", null: false
    t.string "user_answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_answers_on_quiz_id"
  end

  create_table "quiz_results", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "quiz_id", null: false
    t.integer "time_spent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_quiz_results_on_quiz_id"
    t.index ["user_id"], name: "index_quiz_results_on_user_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "question"
    t.string "answer_1"
    t.string "answer_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "title"
    t.datetime "started_at"
    t.float "total_time"
    t.string "select_button_value"
    t.index ["user_id"], name: "index_quizzes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_"
    t.float "total_time"
  end

  add_foreign_key "answers", "quizzes"
  add_foreign_key "quiz_results", "quizzes"
  add_foreign_key "quiz_results", "users"
  add_foreign_key "quizzes", "users"
end

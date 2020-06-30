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

ActiveRecord::Schema.define(version: 2019_04_29_221934) do

  create_table "approvements", force: :cascade do |t|
    t.boolean "approved_tf"
    t.datetime "date_budget_app"
    t.datetime "date_payment_mgr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "budget_code_id"
    t.integer "budget_approver_id"
    t.boolean "approved_er"
    t.integer "travel_id"
    t.decimal "amount"
    t.index ["budget_approver_id"], name: "index_approvements_on_budget_approver_id"
    t.index ["budget_code_id"], name: "index_approvements_on_budget_code_id"
    t.index ["travel_id"], name: "index_approvements_on_travel_id"
  end

  create_table "budget_codes", force: :cascade do |t|
    t.integer "budget_code"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "department_id"
    t.index ["department_id"], name: "index_budget_codes_on_department_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "comment"
    t.string "commented_type"
    t.integer "commented_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "employee_id"
    t.index ["commented_type", "commented_id"], name: "index_comments_on_commented_type_and_commented_id"
    t.index ["employee_id"], name: "index_comments_on_employee_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.integer "department_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "budget"
  end

  create_table "documents", force: :cascade do |t|
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "expense_report_id"
    t.index ["expense_report_id"], name: "index_documents_on_expense_report_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role_id"
    t.integer "department_id"
    t.string "email"
    t.string "password_digest"
    t.index ["department_id"], name: "index_employees_on_department_id"
    t.index ["email"], name: "index_employees_on_email", unique: true
    t.index ["role_id"], name: "index_employees_on_role_id"
  end

  create_table "expense_coverages", force: :cascade do |t|
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "expense_id"
    t.integer "budget_code_id"
    t.index ["budget_code_id"], name: "index_expense_coverages_on_budget_code_id"
    t.index ["expense_id"], name: "index_expense_coverages_on_expense_id"
  end

  create_table "expense_reports", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "travel_id"
    t.boolean "status_er"
    t.boolean "approved_final"
    t.integer "payment_mgr_id"
    t.index ["payment_mgr_id"], name: "index_expense_reports_on_payment_mgr_id"
    t.index ["travel_id"], name: "index_expense_reports_on_travel_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.string "expense_type"
    t.decimal "amount"
    t.string "expensed_type"
    t.integer "expensed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.date "date"
    t.index ["expensed_type", "expensed_id"], name: "index_expenses_on_expensed_type_and_expensed_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "role"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "travels", force: :cascade do |t|
    t.string "destination"
    t.string "purpose"
    t.date "date_of_departure"
    t.date "date_of_return"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "employee_id"
    t.integer "status"
    t.index ["employee_id"], name: "index_travels_on_employee_id"
  end

end

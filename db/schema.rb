# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_04_142731) do

  create_table "attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "attachable_id", null: false
    t.string "attachable_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.float "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer "sequence_num", null: false
    t.integer "user_id"
    t.index ["attachable_id", "attachable_type"], name: "index_attachments_on_attachable_id_and_attachable_type"
    t.index ["company_id"], name: "index_attachments_on_company_id"
    t.index ["sequence_num", "company_id"], name: "index_attachments_on_sequence_num_and_company_id", unique: true
  end

  create_table "attendances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "user_id", null: false
    t.datetime "login_time"
    t.datetime "logout_time"
    t.date "date", null: false
    t.integer "status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_attendances_on_company_id"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "audits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "commentable_id", null: false
    t.string "commentable_type", null: false
    t.integer "user_id"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"
    t.index ["company_id"], name: "index_comments_on_company_id"
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "status"
    t.string "name", null: false
    t.string "subdomain", null: false
    t.integer "owner_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_companies_on_owner_id"
  end

  create_table "company_settings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "company_id", null: false
    t.string "time_zone"
    t.integer "leaves", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_company_settings_on_company_id"
  end

  create_table "delayed_jobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "company_id", null: false
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.index ["company_id"], name: "index_departments_on_company_id"
    t.index ["sequence_num", "company_id"], name: "index_departments_on_sequence_num_and_company_id", unique: true
  end

  create_table "events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "company_id", null: false
    t.datetime "start", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "created_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.datetime "end"
    t.index ["company_id"], name: "index_events_on_company_id"
    t.index ["created_by_id"], name: "index_events_on_created_by_id"
    t.index ["sequence_num", "company_id"], name: "index_events_on_sequence_num_and_company_id", unique: true
  end

  create_table "holidays", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "company_id", null: false
    t.date "day"
    t.boolean "every_year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_holidays_on_company_id"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "company_id", null: false
    t.string "title", null: false
    t.text "description"
    t.boolean "read", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_notifications_on_company_id"
  end

  create_table "projects", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.integer "company_id", null: false
    t.text "description"
    t.string "status", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "expected_start_date"
    t.datetime "expected_end_date"
    t.integer "created_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.index ["company_id"], name: "index_projects_on_company_id"
    t.index ["created_by_id"], name: "index_projects_on_created_by_id"
    t.index ["sequence_num", "company_id"], name: "index_projects_on_sequence_num_and_company_id", unique: true
  end

  create_table "projects_departments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "project_id", null: false
    t.integer "department_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_projects_departments_on_company_id"
    t.index ["department_id"], name: "index_projects_departments_on_department_id"
    t.index ["project_id", "department_id"], name: "index_projects_departments_on_project_id_and_department_id", unique: true
    t.index ["project_id"], name: "index_projects_departments_on_project_id"
  end

  create_table "projects_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_projects_users_on_company_id"
    t.index ["project_id", "user_id"], name: "index_projects_users_on_project_id_and_user_id", unique: true
    t.index ["project_id"], name: "index_projects_users_on_project_id"
    t.index ["user_id"], name: "index_projects_users_on_user_id"
  end

  create_table "tasks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "company_id", null: false
    t.string "title", null: false
    t.text "description"
    t.integer "assignee_id"
    t.integer "created_by_id"
    t.string "status", null: false
    t.datetime "due_date"
    t.integer "project_id", null: false
    t.integer "reviewer_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "progress"
    t.datetime "expected_end_date"
    t.datetime "expected_start_date"
    t.integer "priority", null: false
    t.bigint "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sequence_num", null: false
    t.index ["assignee_id"], name: "index_tasks_on_assignee_id"
    t.index ["created_by_id"], name: "index_tasks_on_created_by_id"
    t.index ["parent_id"], name: "index_tasks_on_parent_id"
    t.index ["project_id"], name: "index_tasks_on_project_id"
    t.index ["reviewer_id"], name: "index_tasks_on_reviewer_id"
    t.index ["sequence_num", "company_id"], name: "index_tasks_on_sequence_num_and_company_id", unique: true
  end

  create_table "tasks_watchers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "company_id", null: false
    t.integer "task_id", null: false
    t.integer "watcher_id", null: false
    t.string "watcher_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_tasks_watchers_on_company_id"
    t.index ["task_id", "watcher_id", "watcher_type"], name: "index_tasks_watchers_on_task_id_and_watcher_id_and_watcher_type"
    t.index ["task_id"], name: "index_tasks_watchers_on_task_id"
  end

  create_table "teams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "company_id", null: false
    t.integer "lead_id", null: false
    t.integer "sequence_num", null: false
    t.integer "created_by_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_teams_on_company_id"
    t.index ["created_by_id"], name: "index_teams_on_created_by_id"
    t.index ["lead_id"], name: "index_teams_on_lead_id"
  end

  create_table "time_logs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "task_id"
    t.integer "company_id", null: false
    t.integer "user_id", null: false
    t.decimal "hours", precision: 5, scale: 2
    t.integer "activity_id"
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_time_logs_on_company_id"
    t.index ["task_id"], name: "index_time_logs_on_task_id"
    t.index ["user_id"], name: "index_time_logs_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.integer "role_id"
    t.integer "company_id", null: false
    t.integer "department_id"
    t.boolean "active", default: true, null: false
    t.string "sys_generated_password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "sequence_num", null: false
    t.index ["company_id", "email"], name: "index_users_on_company_id_and_email", unique: true
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["sequence_num", "company_id"], name: "index_users_on_sequence_num_and_company_id", unique: true
  end

  create_table "users_teams", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "user_id", null: false
    t.integer "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_users_teams_on_company_id"
    t.index ["team_id", "user_id"], name: "index_users_teams_on_team_id_and_user_id", unique: true
    t.index ["team_id"], name: "index_users_teams_on_team_id"
    t.index ["user_id"], name: "index_users_teams_on_user_id"
  end

  create_table "working_days", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "company_id", null: false
    t.time "from"
    t.time "to"
    t.integer "day"
    t.boolean "off_day"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_working_days_on_company_id"
  end

end

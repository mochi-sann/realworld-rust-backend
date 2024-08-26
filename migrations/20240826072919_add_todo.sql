-- Create index "idx_todo_tags_name" to table: "tags"
CREATE INDEX "idx_todo_tags_name" ON "tags" ("name");
-- Create index "idx_new_todo_user_email" to table: "users"
CREATE INDEX "idx_new_todo_user_email" ON "users" ("email");
-- Create "todo_tags" table
CREATE TABLE "todo_tags" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "name" character varying(50) NOT NULL, PRIMARY KEY ("id"), CONSTRAINT "todo_tags_name_key" UNIQUE ("name"));
-- Create "statuses" table
CREATE TABLE "statuses" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "name" character varying(50) NOT NULL, PRIMARY KEY ("id"), CONSTRAINT "statuses_name_key" UNIQUE ("name"));
-- Create index "idx_statuses_name" to table: "statuses"
CREATE INDEX "idx_statuses_name" ON "statuses" ("name");
-- Create "new_todo_user" table
CREATE TABLE "new_todo_user" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "username" character varying(50) NOT NULL, "email" character varying(100) NOT NULL, "password" character varying(255) NOT NULL, "created_at" timestamp NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"), CONSTRAINT "new_todo_user_email_key" UNIQUE ("email"), CONSTRAINT "new_todo_user_username_key" UNIQUE ("username"));
-- Create "tasks" table
CREATE TABLE "tasks" ("id" uuid NOT NULL DEFAULT uuid_generate_v4(), "user_id" uuid NULL, "title" character varying(255) NOT NULL, "description" text NULL, "status_id" uuid NULL, "due_date" date NULL, "created_at" timestamp NULL DEFAULT CURRENT_TIMESTAMP, "updated_at" timestamp NULL DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY ("id"), CONSTRAINT "tasks_status_id_fkey" FOREIGN KEY ("status_id") REFERENCES "statuses" ("id") ON UPDATE NO ACTION ON DELETE SET NULL, CONSTRAINT "tasks_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "new_todo_user" ("id") ON UPDATE NO ACTION ON DELETE CASCADE);
-- Create index "idx_tasks_user_id" to table: "tasks"
CREATE INDEX "idx_tasks_user_id" ON "tasks" ("user_id");
-- Create "task_todo_tags" table
CREATE TABLE "task_todo_tags" ("task_id" uuid NOT NULL, "tag_id" uuid NOT NULL, PRIMARY KEY ("task_id", "tag_id"), CONSTRAINT "task_todo_tags_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "todo_tags" ("id") ON UPDATE NO ACTION ON DELETE CASCADE, CONSTRAINT "task_todo_tags_task_id_fkey" FOREIGN KEY ("task_id") REFERENCES "tasks" ("id") ON UPDATE NO ACTION ON DELETE CASCADE);

-- Create "tags" table
CREATE TABLE "tags" (
  "id" serial NOT NULL,
  "name" text NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
-- Create index "idx_todo_tags_name" to table: "tags"
CREATE INDEX "idx_todo_tags_name" ON "tags" ("name");
-- Create "users" table
CREATE TABLE "users" (
  "id" serial NOT NULL,
  "username" text NOT NULL,
  "email" text NOT NULL,
  "password" text NOT NULL,
  "bio" text NULL,
  "image" text NULL,
  "created_at" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id"),
  CONSTRAINT "users_email_key" UNIQUE ("email")
);
-- Create index "idx_new_todo_user_email" to table: "users"
CREATE INDEX "idx_new_todo_user_email" ON "users" ("email");

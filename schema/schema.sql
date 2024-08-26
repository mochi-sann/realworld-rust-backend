-- Create "_sqlx_migrations" table
-- Create "tags" table
CREATE TABLE "tags" (
  "id" serial NOT NULL,
  "name" TEXT NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Create "refresh_updated_at_step1" function
CREATE FUNCTION "refresh_updated_at_step1" () RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  IF NEW.updated_at = OLD.updated_at THEN
    NEW.updated_at := NULL;
  END IF;
  RETURN NEW;
END;
$$;

-- Create trigger "refresh_tags_updated_at_step1"
CREATE TRIGGER "refresh_tags_updated_at_step1" BEFORE
UPDATE
  ON "tags" FOR EACH ROW EXECUTE FUNCTION "refresh_updated_at_step1"();

-- Create "refresh_updated_at_step2" function
CREATE FUNCTION "refresh_updated_at_step2" () RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  IF NEW.updated_at IS NULL THEN
    NEW.updated_at := OLD.updated_at;
  END IF;
  RETURN NEW;
END;
$$;

-- Create trigger "refresh_tags_updated_at_step2"
CREATE TRIGGER "refresh_tags_updated_at_step2" BEFORE
UPDATE
  OF "updated_at" ON "tags" FOR EACH ROW EXECUTE FUNCTION "refresh_updated_at_step2"();

-- Create "refresh_updated_at_step3" function
CREATE FUNCTION "refresh_updated_at_step3" () RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  IF NEW.updated_at IS NULL THEN
    NEW.updated_at := CURRENT_TIMESTAMP;
  END IF;
  RETURN NEW;
END;
$$;

-- Create trigger "refresh_tags_updated_at_step3"
CREATE TRIGGER "refresh_tags_updated_at_step3" BEFORE
UPDATE
  ON "tags" FOR EACH ROW EXECUTE FUNCTION "refresh_updated_at_step3"();

-- Create "users" table
CREATE TABLE "users" (
  "id" serial NOT NULL,
  "username" TEXT NOT NULL,
  "email" TEXT NOT NULL UNIQUE,
  "password" TEXT NOT NULL,
  "bio" TEXT NULL,
  "image" TEXT NULL,
  "created_at" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

-- Create trigger "refresh_users_updated_at_step1"
CREATE TRIGGER "refresh_users_updated_at_step1" BEFORE
UPDATE
  ON "users" FOR EACH ROW EXECUTE FUNCTION "refresh_updated_at_step1"();

-- Create trigger "refresh_users_updated_at_step2"
CREATE TRIGGER "refresh_users_updated_at_step2" BEFORE
UPDATE
  OF "updated_at" ON "users" FOR EACH ROW EXECUTE FUNCTION "refresh_updated_at_step2"();

-- Create trigger "refresh_users_updated_at_step3"
CREATE TRIGGER "refresh_users_updated_at_step3" BEFORE
UPDATE
  ON "users" FOR EACH ROW EXECUTE FUNCTION "refresh_updated_at_step3"();



CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE statuses (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE tasks (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    status_id UUID REFERENCES statuses(id) ON DELETE SET NULL,
    due_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tags (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE task_tags (
    task_id UUID REFERENCES tasks(id) ON DELETE CASCADE,
    tag_id UUID REFERENCES tags(id) ON DELETE CASCADE,
    PRIMARY KEY (task_id, tag_id)
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_tasks_user_id ON tasks(user_id);
CREATE INDEX idx_tags_name ON tags(name);
CREATE INDEX idx_statuses_name ON statuses(name);

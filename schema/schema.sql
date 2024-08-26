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

-- Add down migration script here
DROP TRIGGER IF EXISTS refresh_tags_updated_at_step1 ON tags;
DROP TRIGGER IF EXISTS refresh_tags_updated_at_step2 ON tags;
DROP TRIGGER IF EXISTS refresh_tags_updated_at_step3 ON tags;

DROP TABLE IF EXISTS tags;


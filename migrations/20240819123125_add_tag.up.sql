-- Add up migration script here
CREATE TABLE tags (
  id SERIAL PRIMARY KEY,
  name TEXT not NULL ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER refresh_tags_updated_at_step1
  BEFORE UPDATE ON tags FOR EACH ROW
  EXECUTE PROCEDURE refresh_updated_at_step1();
CREATE TRIGGER refresh_tags_updated_at_step2
  BEFORE UPDATE OF updated_at ON tags FOR EACH ROW
  EXECUTE PROCEDURE refresh_updated_at_step2();
CREATE TRIGGER refresh_tags_updated_at_step3
  BEFORE UPDATE ON tags FOR EACH ROW
  EXECUTE PROCEDURE refresh_updated_at_step3();

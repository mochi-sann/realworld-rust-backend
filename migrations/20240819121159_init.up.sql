-- Add up migration script here

CREATE FUNCTION refresh_updated_at_step1() RETURNS trigger AS
$$
BEGIN
  IF NEW.updated_at = OLD.updated_at THEN
    NEW.updated_at := NULL;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION refresh_updated_at_step2() RETURNS trigger AS
$$
BEGIN
  IF NEW.updated_at IS NULL THEN
    NEW.updated_at := OLD.updated_at;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION refresh_updated_at_step3() RETURNS trigger AS
$$
BEGIN
  IF NEW.updated_at IS NULL THEN
    NEW.updated_at := CURRENT_TIMESTAMP;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- 対象のテーブルにはこれをいれる
-- CREATE TRIGGER refresh_users_updated_at_step1
--   BEFORE UPDATE ON users FOR EACH ROW
--   EXECUTE PROCEDURE refresh_updated_at_step1();
-- CREATE TRIGGER refresh_users_updated_at_step2
--   BEFORE UPDATE OF updated_at ON users FOR EACH ROW
--   EXECUTE PROCEDURE refresh_updated_at_step2();
-- CREATE TRIGGER refresh_users_updated_at_step3
--   BEFORE UPDATE ON users FOR EACH ROW
--   EXECUTE PROCEDURE refresh_updated_at_step3();
--

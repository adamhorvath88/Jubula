CREATE OR REPLACE FUNCTION trf_node_track_before()
  RETURNS trigger AS
$BODY$
BEGIN
	IF (TG_OP = 'INSERT') THEN
		new.track_comment = new.track_comment || '-' || current_user;
	END IF;
	RETURN new;
END;
$BODY$
  LANGUAGE plpgsql;

CREATE TRIGGER tr_track_user
  BEFORE INSERT
  ON node_track
  FOR EACH ROW
  EXECUTE PROCEDURE trf_node_track_before();

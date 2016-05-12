
/*
 * Lists actions by date, project version, user.
 * NOTE: Not every action is logged in "node_track" table: Mapping, AUT-configs etc. are missing.
 */
CREATE OR REPLACE VIEW tracking AS 
  SELECT DISTINCT to_timestamp(nt."timestamp"::double precision / 1000::double precision) AS to_timestamp, pn.name, pp.major_number, pp.minor_number, n.name AS node, nt.track_comment
    FROM node_track nt
    LEFT JOIN node n ON n.id = nt.node_id
    LEFT JOIN reused_projects rp ON rp.parent_proj = n.parent_proj
    LEFT JOIN project_properties pp ON pp.id = rp.fk_proj_properties
    LEFT JOIN project_names pn ON pn.guid = pp.guid
   ORDER BY to_timestamp;

CREATE TEMP TABLE users(id bigserial, group_id bigint);
INSERT INTO users(group_id) VALUES (1), (1), (1), (2), (1), (3);

WITH subgroups AS (
  SELECT *,
    id - ROW_NUMBER() OVER (PARTITION BY group_id ORDER BY id) AS subgroup
  FROM users
)
SELECT COUNT(*) as records_count, MIN(id) as min_id
FROM subgroups
GROUP  BY group_id,
  subgroup
ORDER BY min_id;
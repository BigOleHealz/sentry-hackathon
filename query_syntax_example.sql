-- use this one as the query template to convert the UUID to readable format
-- change column and table name accordingly
SELECT 
  CONCAT_WS('-',
    SUBSTR(HEX(_id), 1, 8),
    SUBSTR(HEX(_id), 9, 4),
    SUBSTR(HEX(_id), 13, 4),
    SUBSTR(HEX(_id), 17, 4),
    SUBSTR(HEX(_id), 21)
  ) AS formatted_uuid,
  ServiceName,
  Description
FROM
  Services_Offered;
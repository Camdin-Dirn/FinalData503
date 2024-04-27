CREATE TABLE newjson2 as 
SELECT raw_json['data']['home_search']['results']['0'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['1'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['2'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['3'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['4'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['5'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['6'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['7'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['8'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['9'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['10'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['11'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['12'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['13'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['14'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['15'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['16'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['17'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['18'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['19'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['20'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['21'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['22'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['23'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['24'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['25'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['26'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['27'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['28'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['29'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['30'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['31'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['32'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['33'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['34'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['35'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['36'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['37'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['38'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['39'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['40'] AS house FROM raw_data
UNION ALL
SELECT raw_json['data']['home_search']['results']['41'] AS house FROM raw_data;

CREATE TABLE non_json2 as 
SELECT 
  CASE
    WHEN house->'description'->>'beds' = 'null' THEN NULL
    ELSE (house->'description'->>'beds')::int
  END AS beds,
  CASE
    WHEN house->'description'->>'beds_max' = 'null' THEN NULL
    ELSE (house->'description'->>'beds_max')::int
  END as max_beds,
  CASE
    WHEN house->'description'->>'baths' = 'null' THEN NULL
    ELSE (house->'description'->>'baths')::numeric
  END as baths,
  CASE
    WHEN house->'description'->>'baths_max' = 'null' THEN NULL
    ELSE (house->'description'->>'baths_max')::numeric
  END as max_baths,
  CASE
    WHEN house->'description'->>'type' = 'null' THEN NULL
    ELSE (house->'description'->>'type')::text
  END as type,
  CASE
    WHEN house->'description'->>'year_built' = 'null' THEN NULL
    ELSE (house->'description'->>'year_built')::int
  END as year_built,
  CASE
    WHEN house->'description'->>'sqft' = 'null' THEN NULL
    ELSE (house->'description'->>'sqft')::int
  END as sqft,
  CASE
    WHEN house->'description'->>'sqft_max' = 'null' THEN NULL
    ELSE (house->'description'->>'sqft_max')::int
  END as max_sqft,
  CASE
    WHEN house->>'list_price_min' = 'null' THEN NULL
    ELSE (house->>'list_price_min')::int
  END as list_price_min,
  CASE
    WHEN house->>'list_price' = 'null' THEN NULL
    ELSE (house->>'list_price')::int
  END as list_price,
  NULL as sold_price,
  (house->'location'->'address'->>'line')::TEXT as street_num_suff_name,
  (house->>'property_id')::TEXT as property_id,
  (house->'location'->'address'->>'state')::TEXT as state,
  (house->'location'->'address'->>'postal_code')::TEXT as zip_code,
  (house->'location'->'address'->'coordinate'->>'lon')::NUMERIC as lon,
  (house->'location'->'address'->'coordinate'->>'lat')::NUMERIC as lat,
  (house->'location'->'address'->>'city')::TEXT as city,
  (house->'description'->>'lot_sqft')::INT as lot_sqft,
  (house->>'status')::TEXT as status,
  CASE 
  	WHEN house->'list_date' = 'null' THEN NULL
    ELSE ((house->'list_date')::TEXT)::DATE
   END as list_date,
  (house->'description'->>'garage')::INT as garage,
  (house->'description'->>'stories')::INT as stories
FROM newjson2;


CREATE TABLE new_rent_data2 as
SELECT 
	street_num_suff_name,
  CASE 
          WHEN beds IS NULL THEN max_beds 
          ELSE beds 
      END AS beds,
	CASE 
          WHEN baths IS NULL THEN max_baths 
          ELSE baths
      END AS baths,
	CASE 
          WHEN sqft IS NULL THEN max_sqft
          ELSE sqft
      END AS sqft,
  CASE 
          WHEN list_price IS NULL THEN list_price_min
          ELSE sqft
      END AS list_price,
	property_id,
  lot_sqft,
  list_date,
  garage,
  stories,
  type,
  year_built,
  state,
  zip_code,
  lon,
  lat,
  city
FROM non_json2;


INSERT INTO clean_table_testing (
    street_num_suff_name,
  	beds,
    baths,
    type,
    year_built,
    sqft,
    list_price,
		property_id,
    lot_sqft,
    list_date,
    garage,
    stories,
  	city,
    state,
    zip_code,
    lon,
    lat
)
SELECT 
		street_num_suff_name,
  	beds,
    baths,
    type,
    year_built,
    sqft,
    list_price,
		property_id,
    lot_sqft,
    list_date,
    garage,
    stories,
  	city,
    state,
    zip_code,
    lon,
    lat
FROM new_rent_data2
ON CONFLICT (street_num_suff_name) DO UPDATE 
SET 
    type = COALESCE(clean_table_testing.type, EXCLUDED.type), 
    year_built = COALESCE(clean_table_testing.year_built,EXCLUDED.year_built),
    sqft = COALESCE(clean_table_testing.sqft,EXCLUDED.sqft),
    list_price = COALESCE(clean_table_testing.list_price,EXCLUDED.list_price),
    beds = COALESCE(clean_table_testing.beds,EXCLUDED.beds),
    baths = COALESCE(clean_table_testing.baths,EXCLUDED.baths)
    ;

INSERT INTO raw_data_backup  
SELECT * FROM raw_data;

DROP TABLE new_rent_data2;
DROP TABLE non_json2;
DROP TABLE newjson2;

TRUNCATE TABLE raw_data;

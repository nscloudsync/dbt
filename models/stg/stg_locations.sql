-- models/stg_locations.sql
{{
	config(
		materialized = 'table',
		tags = ['stg']
	)
}}

SELECT
    location_id,
    city,
    state_province,
    country_id,
    CURRENT_TIMESTAMP AS load_time
FROM {{ source('hr','src_locations') }}
WHERE city IS NOT NULL
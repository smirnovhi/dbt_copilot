-- models/school__school.sql
{{ config(materialized='table', schema='school') }}

SELECT DISTINCT
  DATA:school_name::STRING AS school_name
FROM {{ source('school', 'json_sample') }}

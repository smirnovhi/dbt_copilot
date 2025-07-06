-- models/school__class.sql
{{ config(materialized='table', schema='school') }}

SELECT DISTINCT
  j.DATA:class::STRING AS class_name,
  s.school_id
FROM {{ source('school', 'json_sample') }} j
JOIN {{ ref('school__school') }} s
  ON s.school_name = j.DATA:school_name::STRING

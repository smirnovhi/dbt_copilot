-- models/school__student_class_school.sql
{{ config(materialized='table', schema='school') }}

WITH src AS (
  SELECT
    s.value:id::STRING AS student_id,
    j.DATA:class::STRING AS class_name,
    j.DATA:school_name::STRING AS school_name
  FROM {{ source('school', 'json_sample') }} j,
       LATERAL FLATTEN(input => j.DATA:students) s
)
SELECT
  src.student_id,
  c.class_id,
  sch.school_id
FROM src
JOIN {{ ref('school__school') }} sch
  ON sch.school_name = src.school_name
JOIN {{ ref('school__class') }} c
  ON c.class_name = src.class_name AND c.school_id = sch.school_id
JOIN {{ ref('school__student') }} st
  ON st.student_id = src.student_id

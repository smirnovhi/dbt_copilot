-- models/school__grade.sql
{{ config(materialized='table', schema='school') }}

SELECT
  student.value:id::STRING AS student_id,
  student.value:grade.math::INTEGER AS math,
  student.value:grade.physics::INTEGER AS physics,
  student.value:grade.chemistry::INTEGER AS chemistry
FROM {{ source('school', 'json_sample') }} j,
     LATERAL FLATTEN(input => j.DATA:students) student
JOIN {{ ref('school__student') }} st
  ON st.student_id = student.value:id::STRING

-- models/school__student.sql
{{ config(materialized='table', schema='school') }}

SELECT DISTINCT
  student.value:id::STRING AS student_id,
  student.value:name::STRING AS name
FROM {{ source('school', 'json_sample') }} j,
     LATERAL FLATTEN(input => j.DATA:students) student

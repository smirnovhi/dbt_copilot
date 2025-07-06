# Exercise: Normalizing School JSON Data and Documenting with dbt & ERD 
# Snowflake
# VS Code
# GitHub Copilot, model GPT-4.1

This project demonstrates how to normalize a JSON sample representing a school, its classes, students, and their grades into a relational schema using dbt, and how to document the resulting structure with an Entity Relationship Diagram (ERD).

## Steps Performed

1. **JSON Ingestion**
   - Loaded the sample JSON into a Snowflake table (`JSON_SAMPLE`) with a `VARIANT` column.

1. **Schema Normalization**
   - Created the following tables:
     - `SCHOOL`: Unique schools.
     - `CLASS`: Classes, each linked to a school.
     - `STUDENT`: Students, independent of class or school.
     - `STUDENT_CLASS_SCHOOL`: Bridge table associating students, classes, and schools (supports many-to-many relationships).
     - `GRADE`: Grades for each student.
     parse_sample.sql

1. **Data Population**
   - Used SQL `INSERT` statements with `SELECT` and `LATERAL FLATTEN` to extract and insert normalized data from the JSON sample into the respective tables.
   parse_sample.sql

1. **ERD gerneration**
    - Create mermaid and DBML schema

1. **dbt Model Generation**
   - Converted the normalization logic into dbt models using the `schema__table` naming convention.
   - Defined the source table in `models/schema.yml` as:

6. **Model Structure**
   - `school__school`: Extracts unique schools from the JSON sample.
   - `school__class`: Extracts classes and links them to schools.
   - `school__student`: Extracts students.
   - `school__student_class_school`: Bridge table associating students, classes, and schools.
   - `school__grade`: Extracts grades for each student.

7. **ERD Documentation**
   - See `sample.dbml` and `sample.mermaid` for DBML and Mermaid ERD diagrams and further documentation.

8. **Show students from schoool** 

```
SELECT
  st.STUDENT_ID,
  st.NAME,
  sch.SCHOOL_NAME
FROM DEV.PUBLIC.STUDENT st
JOIN DEV.PUBLIC.STUDENT_CLASS_SCHOOL scs
  ON st.STUDENT_ID = scs.STUDENT_ID
JOIN DEV.PUBLIC.SCHOOL sch
  ON scs.SCHOOL_ID = sch.SCHOOL_ID;
```    


## Issues:
  - Initially identified SCHOOL and CLASSES as one object(medium) - resolved after additional request 
  - Student foreign keys SHOOL_ID and CLASS_ID  (minor)
  - Syntax errors found. Partially resolved by Copilot, one query corrected manually (high)
  - Cannot visualize. Pointed to services for visualisation

## Sample json:
```json
{"school_name": "Dunder Miflin",
    "class": "Year 1",
    "students": [
    {
        "id": "A1",
        "name": "Jim",
        "grade": {
            "math": 60,
            "physics": 66,
            "chemistry": 61
        }
  
    },
    {
        "id": "A2",
        "name": "Dwight",
        "grade": {
            "math": 89,
            "physics": 76,
            "chemistry": 51
        }
        
    },
    {
        "id": "A3",
        "name": "Kevin",
        "grade": {
            "math": 79,
            "physics": 90,
            "chemistry": 78
        }
    }]
}'
```

- Time of exersize with documentation - 1hr
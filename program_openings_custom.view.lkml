view: program_openings_custom {
  sql_table_name: program_openings ;;

  dimension: id {
    primary_key: yes
    hidden:  yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: test {
    label: "test"
    type: string
    sql:COLUMN_GET(${TABLE}.custom_data,'rooms' AS CHAR(255));;
  }


}

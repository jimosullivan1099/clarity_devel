view: program_openings_custom {
  sql_table_name: program_openings ;;

  dimension: id {
    primary_key: yes
    hidden:  yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: rooms {
    label: "rooms"
    type: string
    sql:COLUMN_GET(${TABLE}.custom_data,'rooms' AS CHAR(255)));;
  }


}

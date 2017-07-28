view: program_staff {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: ref_program {
    type: number
    sql: ${TABLE}.ref_program ;;
  }

  dimension: ref_user {
    type: number
    sql: ${TABLE}.ref_user ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }

  dimension: departments {
    label: "Department"
    type: number
    sql: ${TABLE}.departments ;;
  }
}

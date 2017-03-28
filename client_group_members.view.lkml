view: client_group_members {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: end {
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.end_date ;;
  }

  dimension: ref_client {
    type: number
    sql: ${TABLE}.ref_client ;;
  }

  dimension: ref_group {
    type: number
    sql: ${TABLE}.ref_group ;;
  }

  dimension: ref_type {
    type: number
    sql: ${TABLE}.ref_type ;;
  }

  dimension_group: start {
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.start_date ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
view: program_openings {
  sql_table_name: program_openings ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: date {
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.date ;;
  }

  dimension: note {
    type: string
    sql: ${TABLE}.note ;;
  }

  dimension: ref_program {
    type: number
    hidden: yes
    sql: ${TABLE}.ref_program ;;
  }

  dimension: open_referrals {
    type: number
    sql: (
      SELECT COUNT(*)
      FROM referrals r
      WHERE r.ref_opening = ${TABLE}.id
        AND r.deleted is NULL
      )
       ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}

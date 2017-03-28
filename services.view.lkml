view: services {
  dimension: id {
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: service_id {
    primary_key: yes
    type: number
    sql: ${client_services.id} ;;
  }

  dimension: name {
    bypass_suggest_restrictions: yes
    sql: ${TABLE}.name ;;
  }

  dimension: service_item_name {
    sql: ${service_items.name} ;;
  }

  dimension: service_item_id {
    sql: ${service_items.id} ;;
  }

  dimension: service_notes {
    sql: ${client_service_notes.notes} ;;
  }

  dimension_group: start_date {
    type: time
    timeframes: [time, date, week, month, raw]
    sql: ${client_services.start_date} ;;
  }

  dimension: status {
    label: "Service Active"

    case: {
      when: {
        sql: ${TABLE}.status = 1 ;;
        label: "Active"
      }

      when: {
        sql: ${TABLE}.status = 2 ;;
        label: "Inactive"
      }
    }
  }

  filter: date_filter {
    label: "Service Date Filter"
    type: date
    sql: ${start_date_raw} <= {% date_end date_filter %}
      AND ${end_date_raw} >= {% date_start date_filter %}
       ;;
  }

  dimension: start_date_or_report_start {
    type: date
    hidden: yes
    sql: CASE
      WHEN COALESCE ({% date_start date_filter %},${start_date_raw}) <= ${start_date_raw}
      THEN ${start_date_raw}
      ELSE
      {% date_start date_filter %}
      END
       ;;
  }

  dimension: end_date_or_report_end {
    hidden: yes
    type: date
    sql: CASE
      WHEN COALESCE ({% date_end date_filter %},${end_date_raw}) >= ${end_date_raw}
      THEN ${end_date_raw}
      ELSE
      {% date_end date_filter %}
      END
       ;;
  }

  measure: first_start {
    label: "First Start Date"
    type: date
    sql: CASE
      WHEN MIN( COALESCE(${client_services.start_date},'1900-01-01')) = '1900-01-01' THEN
      NULL
      ELSE MIN( COALESCE(${client_services.start_date},'1900-01-01'))
      END
       ;;
  }

  measure: last_start {
    label: "Last Start Date"
    type: date
    sql: CASE
      WHEN MAX( COALESCE(${client_services.start_date},'1900-01-01')) = '1900-01-01' THEN
      NULL
      ELSE MAX( COALESCE(${client_services.start_date},'1900-01-01'))
      END
       ;;
  }

  dimension_group: end_date {
    type: time
    timeframes: [time, date, week, month, raw]
    sql: ${client_services.end_date} ;;
  }

  dimension: ref_user {
    label: "User Creating"
    sql: ${client_services.ref_user} ;;
  }

  dimension: ref_user_updated {
    label: "User Updating"
    sql: ${client_services.ref_user_updated} ;;
  }

  dimension: ref_agency {
    hidden: yes
    type: number
    sql: ${TABLE}.ref_agency ;;
  }

  dimension: ref_category {
    label: "Service Category"
    bypass_suggest_restrictions: yes
    sql: fn_getPicklistValueName('service_categories',${TABLE}.ref_category) ;;
  }

  measure: days_of_longterm_service {
    label: "Days of Service (Long Term)"
    hidden: yes
    #X# bypass_suggest_restrictions:true
    type: number
    sql: SUM(DATEDIFF(${end_date_or_report_end},${start_date_or_report_start})) ;;
  }

  measure: attendance_days_in_period {
    hidden: yes
    sql: COUNT(CASE WHEN ${service_dates.date_raw} >= COALESCE({% date_start date_filter %} , ${service_dates.date_raw} )
      AND ${service_dates.date_raw} < COALESCE({% date_end date_filter %} , ${service_dates.date_raw})
      THEN ${service_dates.date_raw} ELSE NULL END)
       ;;
  }

  measure: total_days {
    label: "Total Days of Service"
    description: "Sums total days service was provided during the reporting period. Takes into account Long Term and Daily Attendance services."
    type: number
    sql: (CASE
      WHEN ${service_items.ref_delivery_type} = 1 THEN
      (${days_of_longterm_service})
      ELSE ${attendance_days_in_period}
      END )
       ;;
  }

  dimension: delivery_type {
    bypass_suggest_restrictions: yes

    case: {
      when: {
        sql: ${service_items.ref_delivery_type} = 1 ;;
        label: "Long Term"
      }

      when: {
        sql: ${service_items.ref_delivery_type} = 2 ;;
        label: "Daily Attendance"
      }

      when: {
        sql: ${service_items.ref_delivery_type} = 3 ;;
        label: "Multiple Attendance"
      }
    }
  }

  measure: count {
    type: count
  }
}
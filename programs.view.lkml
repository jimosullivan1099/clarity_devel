view: programs {
  sql_table_name: programs
    ;;

  dimension: id {
    primary_key: yes
    description: "Internal project ID number, auto generated by Clarity (HMIS Data Element 2.2.1)"
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: added {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.added_date ;;
  }

  dimension: aff_res_proj {
    label: "Affiliated with a Residential Project"
    description: "For Services Only Projects (HMIS Data Element 2.4.2.A)"
    type: number
    sql: ${TABLE}.aff_res_proj ;;
  }

  dimension: aff_res_proj_ids {
    label: "Affiliated Project Ids"
    description: "For Services Only Projects, ID of Affiliated Project (HMIS Data Element 2.2.4.B)"
    sql: ${TABLE}.aff_res_proj_ids ;;
  }

  dimension: allow_autoservice_placement {
    type: number
    sql: ${TABLE}.allow_autoservice_placement ;;
  }

  dimension: allow_goals {
    type: yesno
    sql: ${TABLE}.allow_goals ;;
  }

  dimension: allow_history_link {
    type: yesno
    sql: ${TABLE}.allow_history_link ;;
  }

  dimension: autoexit_duration {
    type: number
    sql: ${TABLE}.autoexit_duration ;;
  }

  dimension_group: availability_end {
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.availability_end ;;
  }

  dimension_group: availability_start {
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.availability_start ;;
  }

  dimension: cascade_threshold {
    type: number
    sql: ${TABLE}.cascade_threshold ;;
  }

  dimension: availability {
    case: {
      when: {
        sql: ${TABLE}.availability = 1 ;;
        label: "Limited"
      }

      when: {
        sql: ${TABLE}.availability = 2 ;;
        label: "Full"
      }

      else: "None"
    }
  }

  dimension: close_services {
    type: yesno
    sql: ${TABLE}.close_services ;;
  }

  dimension: cross_agency {
    type: yesno
    sql: ${TABLE}.cross_agency ;;
  }

  dimension: description {
    sql: ${TABLE}.description ;;
  }

  dimension: eligibility_enabled {
    type: number
    sql: ${TABLE}.eligibility_enabled ;;
  }

  dimension: enable_autoexit {
    type: yesno
    sql: ${TABLE}.enable_autoexit ;;
  }

  dimension: enable_cascade {
    type: yesno
    sql: ${TABLE}.enable_cascade ;;
  }

  dimension: enable_charts {
    type: number
    sql: ${TABLE}.enable_charts ;;
  }

  dimension: enable_files {
    type: number
    sql: ${TABLE}.enable_files ;;
  }

  dimension: enable_notes {
    type: number
    sql: ${TABLE}.enable_notes ;;
  }

  dimension: enable_assessments {
    type: yesno
    sql: ${TABLE}.enable_assessments ;;
  }

  dimension: funding_source {
    hidden: yes
    type: number
    sql: ${TABLE}.funding_source ;;
  }

  dimension: geocode {
    sql: ${TABLE}.geocode ;;
  }

  dimension: identifier {
    sql: ${TABLE}.identifier ;;
  }

  dimension_group: last_updated {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_updated ;;
  }

  dimension: name {
    bypass_suggest_restrictions: yes
    description: "Project Name (HMIS Data Element 2.2.2)"
    sql: ${TABLE}.name ;;
  }

  dimension: agency_project_name {
    label: "Full Name"
    bypass_suggest_restrictions: yes
    sql: CONCAT(${agencies.name},' - ',${name}) ;;
  }

  measure: list_of_program_names {
    type: list
    list_field: agency_project_name
  }

  dimension: program_applicability {
    description: "Legacy field replaced by Project Type Code"
    sql: fn_getPicklistValueName('program_applicability',${TABLE}.program_applicability) ;;
  }

  dimension: public_listing {
    type: number
    sql: ${TABLE}.public_listing ;;
  }

  dimension: ref_agency {
    hidden: yes
    type: number
    sql: ${TABLE}.ref_agency ;;
  }

  dimension: ref_category {
    hidden: yes
    type: number
    sql: ${TABLE}.ref_category ;;
  }

  dimension: project_type_code {
    label: "Project Type Code"
    description: "Project Type (HMIS Data Element 2.4.2)"
    bypass_suggest_restrictions: yes
    drill_fields: [agency_project_name]
    #program_categories
    sql: fn_getPicklistValueName('program_categories',${ref_category}) ;;
  }

  dimension: ref_site_type {
    label: "Site Type"
    sql: fn_getPicklistValueName('site_types',${TABLE}.ref_site_type) ;;
  }

  dimension: ref_target_b {
    label: "Target Population"
    description: "Targeted population served by the project (HMIS Data Element 2.9.1)"
    sql: fn_getPicklistValueName('targets_b',${TABLE}.ref_target_b) ;;
  }

  dimension: ref_template {
    hidden: yes
    type: number
    sql: ${TABLE}.ref_template ;;
  }

  dimension: template {
    bypass_suggest_restrictions: yes
    sql: ${program_templates.name} ;;
  }

  dimension: ref_user_updated {
    label: "User Updating"
    sql: fn_getUserNameById(${TABLE}.ref_user_updated) ;;
  }

  dimension: site_id {
    type: number
    hidden: yes
    sql: ${TABLE}.site_id ;;
  }

  dimension: status {
    label: "Program Active"

    case: {
      when: {
        sql: ${TABLE}.status = 1 ;;
        label: "Active"
      }

      when: {
        sql: ${TABLE}.status = 2 ;;
        label: "Inactive"
      }

      else: ""
    }
  }

  dimension: tracking_method {
    description: "For Emergency Shelter Projects, how stays are tracked (HMIS Data Element 2.5.1)"
    sql: fn_getPicklistValueName('tracking_method',${TABLE}.tracking_method) ;;
  }

  dimension: first_client_enrollment_date {
    sql: (select min(start_date) from client_programs where ref_program = ${TABLE}.id)
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [id, name, sites.name, sites.id]
  }
}

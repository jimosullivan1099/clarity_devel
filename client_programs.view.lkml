include: "entry_screen.view.lkml"
view: enrollments {
  sql_table_name: client_programs
    ;;

  dimension: id {
    label: "Project Entry Id"
    description: "(HMIS Data Element 5.6)"
    primary_key: yes
    type: number

    link: {
      label: "Clarity Program Enrollment"
      url: "https://{{ _access_filters[\"site.name\"]] }}.clarityhs.com/clients/{{ clients.id._value }}/programs/{{ value }}"
    }

    link: {
      label: "Clarity Profile"
      url: "https://{{ _access_filters[\"site.name\"]] }}.clarityhs.com/clients/{{ clients.id._value }}/profile"
    }

    sql: ${TABLE}.id ;;
  }

  filter: date_filter {
    label: "Reporting Period Filter"
    description: "(Exit Date is >= beginning date of the period filter or is null) AND Start Date is <= ending date of the period filter. Requires two \"dates\" to set the filter"
    type: date
    sql: ${start_raw} < {% date_end date_filter %}
      AND (${end_raw} >= {% date_start date_filter %} OR ${end_raw} is NULL)
       ;;
  }

  dimension: is_latest_enrollment {
    label: "Is Latest Enrollment"
    type: yesno
    description: "This is the latest enrollment into this project (based on entry date)"
    sql: ${id} = ${client_last_program.id} ;;
  }

  dimension_group: added {
    label: "Date Created"
    description: "Date the Project Enrollment was created (HMIS Data Element 5.1)"
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.added_date ;;
  }

  dimension_group: end {
    label: "Exit"
    description: "Project Exit Date (HMIS Data Element 3.11)"
    type: time
    timeframes: [date, week, month, year, raw]
    convert_tz: no
    sql: ${TABLE}.end_date ;;
  }

  dimension_group: end_date_or_today {
    label: "Exit Date Filter"
    type: time
    timeframes: [date]
    sql: COALESCE(${end_date},NOW()) ;;
  }

  dimension_group: last_updated {
    label: "Date Updated"
    description: "Date the Project Enrollment was last updated (HMIS Data Element 5.2)"
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_updated ;;
  }

  dimension: ref_agency {
    hidden: yes
    type: number
    sql: ${TABLE}.ref_agency ;;
  }

  dimension: ref_client {
    hidden: yes
    label: "Personal Id"
    type: number
    sql: ${TABLE}.ref_client ;;
  }

  dimension: ref_client_group {
    # removed because its not a data standard
    label: "Global Household Id (Profile Household)"
    description: "Clarity generated household id, not unique to project enrollment"
    type: number
    sql: ${TABLE}.ref_client_group ;;
  }

  dimension: ref_department {
    hidden: yes
    type: number
    sql: ${TABLE}.ref_department ;;
  }

  dimension: ref_head {
    hidden: yes
    type: number
    sql: ${TABLE}.ref_head ;;
  }

  dimension: head_of_household {
    description: "If Relationship to Head of Household is Self, Yes. Else No. (HMIS Data Element 3.15)"
    type: yesno
    sql: ${TABLE}.ref_head = ${TABLE}.ref_client ;;
  }

  measure: count_households {
    description: "Number of households"
    type: count_distinct
    sql: ${ref_client} ;;
    drill_fields: [
      id,
      ref_household,
      clients.id,
      clients.full_name,
      start_date,
      end_date
    ]

    filters: {
      field: head_of_household
      value: "yes"
    }
  }


  dimension: ref_household {
    label: "Household Id"
    description: "Household ID unique to Project Enrollment (HMIS Data Element 3.14)"
    type: number
    sql: ${TABLE}.ref_household ;;
  }

  dimension: ref_program {
    label: "Project Id"
    description: "Project or Program for the enrollment (HMIS Data Element 5.05)"
    type: number
    sql: ${TABLE}.ref_program ;;
  }

  dimension: ref_user {
    label: "User Creating"
    description: "User which created the enrollment record"
    sql: fn_getUserNameById(${TABLE}.ref_user) ;;
  }

  dimension: assigned_staff {
    description: "User currently assigned to the enrollment"
    sql: CONCAT(${members.first_name},' ',${members.last_name}) ;;
  }

  dimension: ref_user_updated {
    label: "User Updating"
    description: "User who created &/or updated the enrollment record (HMIS Data Element 5.7)"
    sql: fn_getUserNameById(${TABLE}.ref_user_updated) ;;
  }

  dimension_group: start {
    label: "Entry"
    description: "Project Entry Date (HMIS Data Element 3.10)"
    type: time
    timeframes: [date, week, month, year, raw]
    convert_tz: no
    sql: ${TABLE}.start_date ;;
  }

  dimension: days_since_start {
    label: "Days in Project"
    description: "Number of days between project entry and project exit. If not exited, current date"
    bypass_suggest_restrictions: yes
    #X# Invalid LookML inside "dimension": {"suggest_dimension":null}
    type: number
    sql: DATEDIFF(COALESCE(${end_date},NOW()),${start_date}) ;;
  }

  dimension: days_since_start_tier {
    label: "Days in Project Tier"
    description: "Tiers: Number of days between project entry and project exit. If not exited, current date"
    type: tier
    style: integer
    tiers: [
      0,
      3,
      7,
      30,
      90,
      180,
      365,
      730,
      10000
    ]
    sql: ${days_since_start} ;;
  }

  dimension: days_in_project_during_reporting_period {
    label: "Days in Project During the Reporting Period"
    description: "Number of days the client was enrolled in the project during the reporting period."
    type: number
    sql: DATEDIFF(LEAST(COALESCE(${end_date},NOW()),{% date_end date_filter %}),GREATEST(${start_date},{% date_start date_filter %} )) ;;
  }

  measure: total_days_in_project_during_reporting_period {
    label: "Total Days in Project During the Reporting Period"
    description: "Sum of \"Days in Project During the Reporting Period.\""
    type: sum
    sql: ${days_in_project_during_reporting_period} ;;
  }

  measure: average_duration {
    label: "Average Days in Project"
    description: "Average: Number of days between project entry and project exit. If not exited, current date"
    type: average
    sql: ${days_since_start} ;;
  }

  measure: last_exit {
    label: "Last Exit"
    description: "Latest (maximum) exit date"
    type: date
    sql: CASE
      WHEN MAX( COALESCE(${end_date},'2099-12-31')) = '2099-12-31' THEN
      NULL
      ELSE MAX( COALESCE(${end_date},'2099-12-31'))
      END
       ;;
  }

  measure: last_entry {
    label: "Last Entry"
    description: "Latest (maximum) entry date"
    type: date
    sql: MAX(${start_date}) ;;
  }

  dimension: still_in_program {
    label: "Active in Project"
    description: "Client has not exited the project"
    type: yesno
    sql: ${end_date} IS NULL ;;
  }

  dimension: status {
    hidden: yes
    type: number
    sql: ${TABLE}.status ;;
  }

  dimension: deleted {
    hidden: yes
    type: number
    sql: ${TABLE}.deleted ;;
  }

  dimension: type {
    hidden: yes
    type: number
    sql: ${TABLE}.type ;;
  }

  #  - dimension: enrollment_type
  #   label: 'Individual or Family '
  #    type: string
  #    bypass_suggest_restrictions: true
  #    sql_case:
  #            Individual: ${type} = 1
  #            Family: ${type} = 2
  #            else: unknown

  dimension: family_or_individual {
    label: "Individual or Family"
    description: "If count of household members in enrollment = 1, Individual. If count >1, Family. Else Unknown"
    type: string

    case: {
      when: {
        sql: ${household_entry_screen.total_household_clients} = 1 ;;
        label: "Individual"
      }

      when: {
        sql: ${household_entry_screen.total_household_clients} > 1 ;;
        label: "Family"
      }

      else: "Unknown"
    }
  }

  measure: count {
    description: "Number of Enrollments"
    type: count
  }
}

view: last_screen {
  label: "Update/Exit Screen"
  sql_table_name: client_program_demographics
    ;;

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: added {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.added_date ;;
  }

  dimension: benefits_snap {
    label: "SNAP"
    type: yesno
    group_label: "Non-Cash Benefits"
    sql: ${TABLE}.benefit_snap ;;
  }

  dimension: benefits_medicaid {
    label: "Medicaid"
    type: yesno
    group_label: "Health Insurance"
    sql: ${TABLE}.benefits_medicaid ;;
  }

  dimension: benefits_medicare {
    label: "Medicare"
    type: yesno
    group_label: "Health Insurance"
    sql: ${TABLE}.benefits_medicare ;;
  }

  dimension: benefits_no_insurance {
    label: "No Health Insurance"
    group_label: "Health Insurance"
    type: yesno
    sql: ${TABLE}.benefits_no_insurance ;;
  }

  dimension: benefits_noncash {
    label: "_Any Non Cash Benefit"
    group_label: "Non-Cash Benefits"
    sql: fn_getPicklistValueName('benefits_noncash', ${TABLE}.benefits_noncash) ;;
  }

  dimension: benefits_other {
    hidden: yes
    type: number
    sql: ${TABLE}.benefits_other ;;
  }

  dimension: benefits_other_source {
    hidden: yes
    sql: ${TABLE}.benefits_other_source ;;
  }

  dimension: benefits_private_insurance {
    label: "Private Insurance"
    type: yesno
    group_label: "Health Insurance"
    sql: ${TABLE}.benefits_private_insurance ;;
  }

  dimension: benefits_schip {
    label: "SCHIP"
    type: yesno
    group_label: "Health Insurance"
    sql: ${TABLE}.benefits_schip ;;
  }

  dimension: benefits_section8 {
    label: "Section 8"
    type: yesno
    group_label: "Non-Cash Benefits"
    sql: ${TABLE}.benefits_section8 ;;
  }

  dimension: benefits_tanf_childcare {
    label: "TANF Childcare"
    type: yesno
    group_label: "Non-Cash Benefits"
    sql: ${TABLE}.benefits_tanf_childcare ;;
  }

  dimension: benefits_tanf_other {
    label: "TANF Other"
    type: yesno
    group_label: "Non-Cash Benefits"
    sql: ${TABLE}.benefits_tanf_other ;;
  }

  dimension: benefits_tanf_transportation {
    label: "TANF Transportaion"
    type: yesno
    group_label: "Non-Cash Benefits"
    sql: ${TABLE}.benefits_tanf_transportation ;;
  }

  dimension: benefits_temp_rent {
    label: "Temporary Rental Assistance"
    type: yesno
    group_label: "Non-Cash Benefits"
    sql: ${TABLE}.benefits_temp_rent ;;
  }

  dimension: benefits_va_medical {
    label: "VA Medical Insurance"
    type: yesno
    group_label: "Health Insurance"
    sql: ${TABLE}.benefits_va_medical ;;
  }

  dimension: benefits_wic {
    label: "WIC"
    type: yesno
    group_label: "Non-Cash Benefits"
    sql: ${TABLE}.benefits_wic ;;
  }

  dimension: chronic_1 {
    hidden: yes
    type: number
    sql: ${TABLE}.chronic_1 ;;
  }

  dimension: chronic_2 {
    hidden: yes
    type: number
    sql: ${TABLE}.chronic_2 ;;
  }

  dimension: chronic_3 {
    hidden: yes
    type: number
    sql: ${TABLE}.chronic_3 ;;
  }

  dimension: chronic_4 {
    hidden: yes
    type: number
    sql: ${TABLE}.chronic_4 ;;
  }

  dimension: chronic_5 {
    hidden: yes
    type: number
    sql: ${TABLE}.chronic_5 ;;
  }

  dimension: chronic_homeless {
    hidden: yes
    type: number
    sql: ${TABLE}.chronic_homeless ;;
  }

  dimension: Employed {
    sql: fn_getPicklistValueName('employment_is',${TABLE}.employment_is) ;;
  }

  dimension: any_disability {
    label: "Any Disability"
    type: yesno
    group_label: "Disability Types"
    sql: ${TABLE}.health_chronic = 1 or ${TABLE}.health_dev_disability = 1 or ${TABLE}.health_hiv = 1 or ${TABLE}.health_mental = 1 or ${TABLE}.health_phys_disability = 1 or (${TABLE}.health_substance_abuse =1 or ${TABLE}.health_substance_abuse =2 or ${TABLE}.health_substance_abuse =3  ) ;;
  }

  dimension: disabiing_condition {
    label: "Disabling Condition"
    group_label: "Disability Types"
    sql: fn_getPicklistValueName('disabled',${TABLE}.disabled) ;;
  }

  dimension: exit_destination {
    hidden: yes
    type: number
    sql: ${TABLE}.exit_destination ;;
  }

  dimension: exit_destination_text {
    label: "Exit Destination"
    suggestions: [
      "Client doesn't know",
      "Client refused",
      "Data not collected",
      "Deceased",
      "Emergency Shelter, including hotel or motel paid for with voucher",
      "Foster care home or foster care group home",
      "Hospital or other residential non-psychiatric medical facility",
      "Hotel or motel paid for without emergency shelter voucher",
      "Jail, prison or juvenile detention facility",
      "Long-term care facility or nursing home",
      "Moved from one HOPWA funded project to HOPWA PH",
      "No exit interview completed",
      "Other",
      "Owned by client, no ongoing housing subsidy",
      "Owned by client, with ongoing housing subsidy",
      "Permanent housing for formerly homeless persons",
      "Place not meant for habitation",
      "Psychiatric hospital or other psychiatric facility",
      "Rental by client, no ongoing housing subsidy",
      "Rental by client, with GPD TIP housing subsidy",
      "Rental by client, with other ongoing housing subsidy",
      "Rental by client, with VASH housing subsidy",
      "Residential project or halfway house with no homeless criteria",
      "Safe Haven",
      "Staying or living with family, permanent tenure",
      "Staying or living with family, temporary tenure",
      "Staying or living with friends, permanent tenure",
      "Staying or living with friends, temporary tenure",
      "Substance abuse treatment facility or detox center",
      "Transitional housing for homeless persons"
    ]
    sql: fn_getPicklistValueName('exit_destination',${exit_destination}) ;;
  }

  dimension: housed_on_exit {
    label: "Housed on Exit"
    description: "Client has been Permanently Housed. Based on Exit Destination"

    case: {
      when: {
        sql: ${exit_destination} in (10,11,19,20,21,22,23,26,28,3) ;;
        label: "Housed"
      }

      else: "Not Housed"
    }
  }

  dimension: exit_reason {
    hidden: yes
    type: number
    sql: ${TABLE}.exit_reason ;;
  }

  dimension: exit_reason_text {
    label: "Exit Reason "
    sql: fn_getPicklistValueName('exit_reason',${exit_reason}) ;;
  }

  dimension: health_chronic {
    label: "Chronic Health"
    group_label: "Disability Types"
    sql: fn_getPicklistValueName('health_chronic',${TABLE}.health_chronic) ;;
  }

  #- dimension: health_chronic_documented
  #  type: number
  #  sql: ${TABLE}.health_chronic_documented

  #- dimension: health_chronic_longterm
  #  type: number
  #  sql: ${TABLE}.health_chronic_longterm

  #- dimension: health_chronic_services
  #  type: number
  #  sql: ${TABLE}.health_chronic_services

  dimension: health_chronic_services {
    label: "Chronic Health Services"
    group_label: "Disability Types"
    sql: fn_getPicklistValueName('health_chronic_services',${TABLE}.health_chronic_services) ;;
  }

  dimension: health_chronic_longterm {
    label: "Chronic Health Longterm"
    group_label: "Disability Types"
    sql: fn_getPicklistValueName('health_chronic_longterm',${TABLE}.health_chronic_longterm) ;;
  }

  dimension: health_dev_disability {
    label: "Developmental"
    group_label: "Disability Types"
    sql: fn_getPicklistValueName('health_dev_disability',${TABLE}.health_dev_disability) ;;
  }

  #- dimension: health_dev_disability_documented
  #  type: number
  #  sql: ${TABLE}.health_dev_disability_documented

  #- dimension: health_dev_disability_independence
  #  type: number
  #  sql: ${TABLE}.health_dev_disability_independence

  #- dimension: health_dev_disability_services
  #  type: number
  #  sql: ${TABLE}.health_dev_disability_services

  dimension: health_dev_disability_services {
    label: "Developmental Services"
    group_label: "Disability Types"
    sql: fn_getPicklistValueName('health_dev_disability_services',${TABLE}.health_dev_disability_services) ;;
  }

  dimension: health_dev_disability_independence {
    label: "Developmental Independence"
    group_label: "Disability Types"
    sql: fn_getPicklistValueName('health_dev_disability_independence',${TABLE}.health_dev_disability_independence) ;;
  }

  dimension: health_dv {
    label: "Domestic Violence"
    sql: fn_getPicklistValueName('health_dv',${TABLE}.health_dv) ;;
  }

  #- dimension: health_dv_occurred
  #  type: number
  #  sql: ${TABLE}.health_dv_occurred

  #- dimension: health_general
  #  type: number
  #  sql: ${TABLE}.health_general

  dimension: health_hiv {
    label: "HIV/AIDS"
    group_label: "Disability Types"
    sql: fn_getPicklistValueName('health_hiv',${TABLE}.health_hiv) ;;
  }

  #  - dimension: health_hiv_documented
  #    type: number
  #    sql: ${TABLE}.health_hiv_documented

  #  - dimension: health_hiv_independence
  #    type: number
  #    sql: ${TABLE}.health_hiv_independence

  #  - dimension: health_hiv_services
  #    type: number
  #    sql: ${TABLE}.health_hiv_services

  dimension: health_ins_cobra {
    label: "COBRA"
    type: yesno
    group_label: "Health Insurance"
    sql: ${TABLE}.health_ins_cobra ;;
  }

  dimension: health_ins_emp {
    label: "Employer Provided"
    type: yesno
    group_label: "Health Insurance"
    sql: ${TABLE}.health_ins_emp ;;
  }

  dimension: health_ins_ppay {
    label: "Private Pay"
    type: yesno
    group_label: "Health Insurance"
    sql: ${TABLE}.health_ins_ppay ;;
  }

  dimension: health_ins_state {
    label: "State Insurance for Adults"
    type: yesno
    group_label: "Health Insurance"
    sql: ${TABLE}.health_ins_state ;;
  }

  dimension: health_insurance {
    label: "Covered by Health Insurance"
    group_label: "Health Insurance"
    sql: fn_getPicklistValueName('health_insurance',${TABLE}.health_insurance) ;;
  }

  dimension: health_mental {
    label: "Mental Health"
    group_label: "Disability Types"
    sql: fn_getPicklistValueName('health_mental',${TABLE}.health_mental) ;;
  }

  #   - dimension: health_mental_confirmed
  #     type: number
  #     sql: ${TABLE}.health_mental_confirmed
  #
  #   - dimension: health_mental_documented
  #     type: number
  #     sql: ${TABLE}.health_mental_documented
  #
  #   - dimension: health_mental_longterm
  #     type: number
  #     sql: ${TABLE}.health_mental_longterm
  #
  #   - dimension: health_mental_services
  #     type: number
  #     sql: ${TABLE}.health_mental_services
  #
  #   - dimension: health_mental_smi
  #     type: number
  #     sql: ${TABLE}.health_mental_smi

  dimension: health_mental_services {
    label: "Mental Health Services"
    group_label: "Disability Types"
    sql: fn_getPicklistValueName('health_mental_services',${TABLE}.health_mental_services) ;;
  }

  dimension: health_mental_longterm {
    label: "Mental Health Longterm"
    group_label: "Disability Types"
    sql: fn_getPicklistValueName('health_mental_longterm',${TABLE}.health_mental_longterm) ;;
  }

  dimension: health_phys_disability {
    label: "Physical"
    group_label: "Disability Types"
    sql: fn_getPicklistValueName('health_phys_disability',${TABLE}.health_phys_disability) ;;
  }

  measure: average_cash_income {
    # can be average, sum, min, max, count, count_distinct, or number
    type: average
    value_format_name: usd
    group_label: "Income Sources and Amounts"
    sql: ${income_individual} ;;
  }

  dimension: income_earned_is {
    label: "Earned Income"
    type: yesno
    group_label: "Income Sources and Amounts"
    sql: ${TABLE}.income_earned_is ;;
  }

  dimension: rhy_employment_type {
    label: "Employment Type"
    group_label: "RHY Questions"
    sql: fn_getPicklistValueName('rhy_employment_type',${TABLE}.rhy_employment_type) ;;
  }

  dimension: rhy_reason_not_employed {
    label: "Employed: Why not"
    group_label: "RHY Questions"
    sql: fn_getPicklistValueName('rhy_reason_not_employed',${TABLE}.rhy_reason_not_employed) ;;
  }

  #
  #   - dimension: health_phys_disability_documented
  #     type: number
  #     sql: ${TABLE}.health_phys_disability_documented
  #
  #   - dimension: health_phys_disability_longterm
  #     type: number
  #     sql: ${TABLE}.health_phys_disability_longterm
  #
  #   - dimension: health_phys_disability_services
  #     type: number
  #     sql: ${TABLE}.health_phys_disability_services
  dimension: health_phys_disability_services {
    label: "Physical Services"
    group_label: "Disability Types"
    sql: fn_getPicklistValueName('health_phys_disability_services',${TABLE}.health_phys_disability_services) ;;
  }

  dimension: health_phys_disability_longterm {
    label: "Physical Longterm"
    group_label: "Disability Types"
    sql: fn_getPicklistValueName('health_phys_disability_longterm',${TABLE}.health_phys_disability_longterm) ;;
  }

  #
  #   - dimension: health_pregnancy
  #     type: number
  #     sql: ${TABLE}.health_pregnancy
  #
  #   - dimension_group: health_pregnancy
  #     type: time
  #     timeframes: [date, week, month]
  #     convert_tz: false
  #     sql: ${TABLE}.health_pregnancy_date

  dimension: health_substance_abuse {
    label: "Substance Abuse"
    group_label: "Disability Types"
    sql: fn_getPicklistValueName('health_substance_abuse',${TABLE}.health_substance_abuse) ;;
  }

  #   - dimension: health_substance_abuse_confirmed
  #     type: number
  #     sql: ${TABLE}.health_substance_abuse_confirmed
  #
  #   - dimension: health_substance_abuse_documented
  #     type: number
  #     sql: ${TABLE}.health_substance_abuse_documented
  #
  #   - dimension: health_substance_abuse_longterm
  #     type: number
  #     sql: ${TABLE}.health_substance_abuse_longterm
  #
  #   - dimension: health_substance_abuse_services
  #     type: number
  #     sql: ${TABLE}.health_substance_abuse_services

  dimension: health_substance_abuse_services {
    label: "Substance Abuse Services"
    group_label: "Disability Types"
    sql: fn_getPicklistValueName('health_substance_abuse_services',${TABLE}.health_substance_abuse_services) ;;
  }

  dimension: health_substance_abuse_longterm {
    label: "Substance Abuse Longterm"
    group_label: "Disability Types"
    sql: fn_getPicklistValueName('health_substance_abuse_longterm',${TABLE}.health_substance_abuse_longterm) ;;
  }

  #
  #   - dimension: housing_ass_exit
  #     type: number
  #     sql: ${TABLE}.housing_ass_exit
  #
  #   - dimension: housing_ass_exit_1
  #     type: number
  #     sql: ${TABLE}.housing_ass_exit_1
  #
  #   - dimension: housing_ass_exit_2
  #     type: number
  #     sql: ${TABLE}.housing_ass_exit_2

  dimension: housing_ass_exit {
    label: "Housing Assessment at Exit"
    sql: fn_getPicklistValueName('housing_ass_exit',${TABLE}.housing_ass_exit) ;;
  }

  dimension: housing_status {
    hidden: yes
    type: number
    sql: ${TABLE}.housing_status ;;
  }

  dimension: housing_status_text {
    label: "Housing Status"
    sql: fn_getPicklistValueName('housing_status',${housing_status}) ;;
  }

  #   - dimension: left_stably_housed
  #     type: yesno
  #     sql: ${housing_status_text} = 'Stably housed'
  #
  #
  #   - measure: count_stably_housed
  #     type: count_distinct
  #     sql: ${ref_client}
  #     filters:
  #       housing_status_text: 'Stably housed'

  measure: count_asked_about_housing {
    hidden: yes
    type: count_distinct
    sql: ${ref_client} ;;

    filters: {
      field: housing_status_text
      value: "-NULL"
    }
  }


  dimension: income_cash {
    hidden: yes
    type: number
    sql: ${TABLE}.income_cash ;;
  }

  dimension: income_cash_is {
    hidden: yes
    type: number
    sql: ${TABLE}.income_cash_is ;;
  }

  dimension: any_income {
    label: "_Income from any Source"
    group_label: "Income Sources and Amounts"

    case: {
      when: {
        sql: ${income_cash_is} = 0 ;;
        label: "No Income"
      }

      when: {
        sql: ${income_cash_is} = 1 ;;
        label: "Income"
      }

      else: "Unknown"
    }
  }

  dimension: income_childsupport {
    label: "Child Support Amount"
    type: number
    group_label: "Income Sources and Amounts"
    sql: ${TABLE}.income_childsupport ;;
  }

  dimension: income_childsupport_is {
    label: "Child Support"
    type: yesno
    group_label: "Income Sources and Amounts"
    sql: ${TABLE}.income_childsupport_is ;;
  }

  dimension: income_earned {
    label: "Income: Earned Income Amount"
    type: number
    hidden: yes
    sql: ${TABLE}.income_earned ;;
  }

  dimension: income_earned_tier {
    label: "Earned Income Tiers"
    type: tier
    style: integer
    tiers: [0, 100, 500, 1000, 5000]
    group_label: "Income Sources and Amounts"
    sql: ${income_earned} ;;
  }

  measure: average_income_earned {
    label: "Earned Income Average"
    # can be average, sum, min, max, count, count_distinct, or number
    type: average
    value_format_name: usd
    group_label: "Income Sources and Amounts"
    drill_fields: [detail*]
    sql: ${income_earned} ;;
  }

  measure: total_income_earned {
    label: "Earned Income Total"
    # can be average, sum, min, max, count, count_distinct, or number
    type: sum
    value_format_name: usd
    group_label: "Income Sources and Amounts"
    sql: ${income_earned} ;;
    drill_fields: [detail*]
  }

  measure: count_with_income {
    type: count_distinct
    group_label: "Income Sources and Amounts"
    sql: ${ref_client} ;;

    filters: {
      field: any_income
      value: "Income"
    }
  }

  measure: count_asked_about_income {
    hidden: yes
    type: count_distinct
    group_label: "Income Sources and Amounts"
    sql: ${ref_client} ;;

    filters: {
      field: any_income
      value: "No Income, Income"
    }
  }

  measure: percent_with_income {
    type: number
    format: "%0.1f%"
    group_label: "Income Sources and Amounts"
    sql: 100.0 * ${count_with_income} / NULLIF(${count_asked_about_income},0) ;;
  }

  dimension: income_ga {
    type: number
    hidden: yes
    label: "General Assistance Amount"
    group_label: "Income Sources and Amounts"
    sql: ${TABLE}.income_ga ;;
  }

  dimension: income_ga_is {
    label: "General Assistance"
    type: yesno
    group_label: "Income Sources and Amounts"
    sql: ${TABLE}.income_ga_is ;;
  }

  # TOtal cash income for individual
  dimension: income_individual {
    label: "_Total Cash Income"
    type: number
    value_format_name: usd
    group_label: "Income Sources and Amounts"
    sql: ${TABLE}.income_individual ;;
  }

  # TOtal cash income for individual
  dimension: income_change {
    label: "_Total Change in Cash Income"
    type: number
    value_format_name: usd
    group_label: "Income Sources and Amounts"
    sql: ${TABLE}.income_individual   -   ${entry_screen.income_individual} ;;
  }

  dimension: income_change_tier {
    label: "_Changed Tiers"
    type: tier
    style: integer
    group_label: "Income Sources and Amounts"
    tiers: [0, 100, 500, 1000, 5000]
    sql: ${income_change} ;;
  }

  measure: average_income_change {
    # can be average, sum, min, max, count, count_distinct, or number
    type: average
    value_format_name: usd
    group_label: "Income Sources and Amounts"
    sql: ${income_change} ;;
  }

  measure: total_cash_income {
    # can be average, sum, min, max, count, count_distinct, or number
    type: sum
    value_format_name: usd
    group_label: "Income Sources and Amounts"
    sql: ${income_individual} ;;
  }

  #   - dimension: income_other
  #     type: number
  #     sql: ${TABLE}.income_other
  #
  #   - dimension: income_other_is
  #     type: yesno
  #     sql: ${TABLE}.income_other_is
  #
  #   - dimension: income_other_source
  #     sql: ${TABLE}.income_other_source

  dimension: income_private_disability {
    label: "Income: Private Disability Insurance"
    hidden: yes
    type: number
    sql: ${TABLE}.income_private_disability ;;
  }

  dimension: income_private_disability_is {
    label: "Private Disability Insurance"
    type: yesno
    group_label: "Income Sources and Amounts"
    sql: ${TABLE}.income_private_disability_is ;;
  }

  dimension: income_private_pension {
    hidden: yes
    type: number
    sql: ${TABLE}.income_private_pension ;;
  }

  dimension: income_private_pension_is {
    label: "Private Pension"
    type: yesno
    group_label: "Income Sources and Amounts"
    sql: ${TABLE}.income_private_pension_is ;;
  }

  dimension: income_spousal_support {
    hidden: yes
    type: number
    sql: ${TABLE}.income_spousal_support ;;
  }

  dimension: income_spousal_support_is {
    label: "Spousal Support"
    type: yesno
    group_label: "Income Sources and Amounts"
    sql: ${TABLE}.income_spousal_support_is ;;
  }

  dimension: income_ss_retirement {
    hidden: yes
    type: number
    group_label: "Income Sources and Amounts"
    sql: ${TABLE}.income_ss_retirement ;;
  }

  dimension: income_ss_retirement_is {
    label: "Soc Sec Retirement"
    type: yesno
    group_label: "Income Sources and Amounts"
    sql: ${TABLE}.income_ss_retirement_is ;;
  }

  dimension: income_ssdi {
    hidden: yes
    type: number
    sql: ${TABLE}.income_ssdi ;;
  }

  dimension: income_ssdi_is {
    label: "SSDI"
    group_label: "Income Sources and Amounts"
    sql: ${TABLE}.income_ssdi_is ;;
  }

  dimension: income_ssi {
    hidden: yes
    type: number
    sql: ${TABLE}.income_ssi ;;
  }

  dimension: income_ssi_is {
    label: "SSI"
    type: yesno
    group_label: "Income Sources and Amounts"
    sql: ${TABLE}.income_ssi_is ;;
  }

  dimension: income_tanf {
    hidden: yes
    type: number
    sql: ${TABLE}.income_tanf ;;
  }

  dimension: income_tanf_is {
    label: "TANF"
    type: yesno
    group_label: "Income Sources and Amounts"
    sql: ${TABLE}.income_tanf_is ;;
  }

  dimension: income_unemployment {
    hidden: yes
    label: "Income: Unemployment Amount"
    type: number
    sql: ${TABLE}.income_unemployment ;;
  }

  measure: total_unemployment_income {
    hidden: yes
    label: "Income: Total Unemployment Income"
    # can be average, sum, min, max, count, count_distinct, or number
    type: sum
    value_format_name: usd
    sql: ${income_unemployment} ;;
  }

  dimension: income_unemployment_is {
    label: "Unemployement Income"
    type: yesno
    group_label: "Income Sources and Amounts"
    sql: ${TABLE}.income_unemployment_is ;;
  }

  dimension: income_vet_disability {
    hidden: yes
    type: number
    sql: ${TABLE}.income_vet_disability ;;
  }

  dimension: income_vet_disability_is {
    label: "Veteran Disability"
    type: yesno
    group_label: "Income Sources and Amounts"
    sql: ${TABLE}.income_vet_disability_is ;;
  }

  dimension: income_vet_pension {
    hidden: yes
    type: number
    sql: ${TABLE}.income_vet_pension ;;
  }

  dimension: income_vet_pension_is {
    label: "Veteran Pension"
    type: yesno
    group_label: "Income Sources and Amounts"
    sql: ${TABLE}.income_vet_pension_is ;;
  }

  dimension: income_workers_comp {
    hidden: yes
    type: number
    sql: ${TABLE}.income_workers_comp ;;
  }

  measure: total_workers_comp_income {
    hidden: yes
    label: "Income: Total Unemployment Income"
    # can be average, sum, min, max, count, count_distinct, or number
    type: sum
    format: "$%0.0f"
    sql: ${income_workers_comp} ;;
  }

  dimension: income_workers_comp_is {
    label: "Workers Comp"
    type: yesno
    group_label: "Income Sources and Amounts"
    sql: ${TABLE}.income_workers_comp_is ;;
  }

  dimension_group: last_updated {
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.last_updated ;;
  }

  #   - dimension: marital_status
  #     type: number
  #     sql: ${TABLE}.marital_status

  dimension_group: move_in {
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.move_in_date ;;
  }

  dimension: permanent_housing_is {
    type: number
    sql: ${TABLE}.permanent_housing_is ;;
  }

  dimension_group: path_engagement_date {
    label: "PATH Engagement Date"
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.path_engagement_date ;;
  }

  dimension: path_status_determination {
    type: yesno
    sql: ${TABLE}.path_status_is ;;
  }

  dimension: path_enrollment_status {
    type: yesno
    sql: ${TABLE}.path_status ;;
  }

  dimension_group: path_status_determination_date {
    label: "PATH Determination Date"
    type: time
    timeframes: [date, week, month]
    sql: ${TABLE}.path_status_determination ;;
  }

  dimension: prior_city {
    sql: ${TABLE}.prior_city ;;
  }

  dimension: prior_duration {
    type: number
    sql: ${TABLE}.prior_duration ;;
  }

  dimension: prior_residence {
    hidden: yes
    type: number
    sql: ${TABLE}.prior_residence ;;
  }

  dimension: prior_residence_text {
    label: "Residence Prior to Project Entry"
    sql: fn_getPicklistValueName('prior_residence',${prior_residence}) ;;
  }

  dimension: prior_residence_other {
    hidden: yes
    sql: ${TABLE}.prior_residence_other ;;
  }

  dimension: prior_state {
    sql: ${TABLE}.prior_state ;;
  }

  dimension: prior_street_address {
    sql: ${TABLE}.prior_street_address ;;
  }

  dimension_group: program {
    label: "Information Date"
    type: time
    timeframes: [date, week, month]
    convert_tz: no
    sql: ${TABLE}.program_date ;;
  }

  #   - dimension_group: program_entry
  #     type: time
  #     timeframes: [date, week, month]
  #     convert_tz: false
  #     sql: ${TABLE}.program_entry
  #
  #   - dimension_group: program_exit
  #     type: time
  #     timeframes: [date, week, month]
  #     convert_tz: false
  #     sql: ${TABLE}.program_exit

  dimension: ref_agency {
    hidden: yes
    type: number
    sql: ${TABLE}.ref_agency ;;
  }

  dimension: ref_client {
    hidden: yes
    type: number
    sql: ${TABLE}.ref_client ;;
  }

  dimension: ref_program {
    hidden: yes
    type: number
    sql: ${TABLE}.ref_program ;;
  }

  dimension: ref_user {
    label: "User Creating"
    sql: fn_getUserNameById(${TABLE}.ref_user) ;;
  }

  dimension: ref_user_updated {
    label: "User Updating"
    sql: fn_getUserNameById(${TABLE}.ref_user_updated) ;;
  }

  dimension: screen_type {
    hidden: yes
    type: number
    sql: ${TABLE}.screen_type ;;
  }

  dimension: screen_type_text {
    label: "Screen Type"
    sql: CASE
      WHEN ${screen_type} = 2 THEN '1 - Enrollment'
      WHEN ${screen_type} = 3 THEN '2 - Update'
      WHEN ${screen_type} = 4 THEN '4 - Exit'
      WHEN ${screen_type} = 6 THEN '3 - Annual Assessment'
      END
       ;;
  }

  dimension: zipcode {
    type: zipcode
    sql: ${TABLE}.zipcode ;;
  }

  dimension: zipcode_quality {
    type: number
    sql: ${TABLE}.zipcode_quality ;;
  }

  #   - dimension: days_since_first_screen  <---- Comparison between two screens
  #     type: number
  #     sql: datediff(${added_date},${entry_screen.added_date})

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id
    ]
  }
}

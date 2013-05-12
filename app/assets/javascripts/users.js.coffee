$ ->
  show_boot_dropdown = ->
    $("#boot").change ->
      $("#cohort_dropdown").toggleClass("hidden")
  show_boot_dropdown()

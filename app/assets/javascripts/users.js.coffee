$ ->
  show_boot_dropdown = ->
    $("#boot").change ->
      $("#cohort_dropdown").toggleClass("hidden")
  show_boot_dropdown()

  show_mentor_dropdown = ->
    $("#mentor").change ->
      $("#mentor_dropdown").toggle()
  show_mentor_dropdown()

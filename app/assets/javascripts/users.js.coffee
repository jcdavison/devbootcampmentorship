$ ->
  show_boot_dropdown = ->
    $("#boot").change ->
      $("#cohort_dropdown").toggleClass("hidden")
  show_boot_dropdown()

  show_mentor_dropdown = ->
    $("#mentor").change ->
      $("#mentor_dropdown").toggle()
  show_mentor_dropdown()

  validate_form = ->
    $("#new_user_form").submit ->
      status = "submit"
      $("input.validates").each ( index, element ) =>
        if $(element).val() is ""
          $(element).addClass("error")
          status = "notsubmit"

        if $(element).val() isnt ""
          $(element).removeClass("error")
          status = "submit"

      boot_status = $("#boot").is(":checked")
      if boot_status is true 
        if $("select option:selected").val() is ""
          $("#dropdown_error").removeClass("hidden")
          status = "notsubmit"
      
      mentor_status = $("#mentor").is(":checked")
      if mentor_status is true
        if $("#agreement").is(":checked") is false
          $("#agreement_error").removeClass("hidden")
          status = "notsubmit"
      return false if status is "notsubmit"
      

  validate_form()

  release_cohort_error = ->
    $("#boot").click ->
      if $("#boot").is(":checked") is false && $("#dropdown_error").hasClass("hidden") is false
        console.log "conditions met"
        $("#dropdown_error").addClass("hidden")
  release_cohort_error()




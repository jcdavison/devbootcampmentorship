$ ->

  show_boot_dropdown = ->
    $("#boot").change ->
      $("#cohort_dropdown").toggleClass("hidden")
  show_boot_dropdown()



  validate_form = ->
    $("#new_user_form").submit ->
      submit = true
      if validate_presence() is "invalid" 
        submit = false
      if validate_cohort_selection() is "invalid"
        submit = false
      submit

  validate_presence = ->
    errors = 0
    $("input.validates_presence").each ( index, element ) ->
      if $(element).val().length isnt 0 && $(element).hasClass("error")
        $(element).removeClass("error")
      if $(element).val().length is 0
        $(element).addClass("error")
        presence_error_release(element)
        errors += 1
    if $("#agreement").is(":checked") isnt true && $("#boot").is(":checked") is false
      $("#agreement_error").removeClass("hidden")
      errors += 1
    if errors is 0
      return "valid"
    else
      return "invalid"

  presence_error_release = (element) ->
    $(element).focus ->
      $(element).blur ->
        if $(element).val().length isnt 0 && $(element).hasClass("error")
          $(@).removeClass("error")

  validate_cohort_selection = ->
    input = $("input#boot")
    if input.is(":checked") && $("#cohort_cohort_id").val().length is 0
      $("#cohort_error").removeClass("hidden")
      release_cohort_error()
      return "invalid"
    else
      return "valid"

  release_cohort_error = ->
    $("#cohort_cohort_id").change ->
      $("#cohort_error").addClass("hidden")

  agreement_error_release = ->
    $("#agreement").click ->
      $("#agreement_error").addClass("hidden")
  agreement_error_release()

  validate_form()

$ ->
  notify_pairs = ->
    notify = $("#notify_pairs")
    notify.click ->
      $.ajax
        type: "POST"
        url: "/notify"
        data: {
          cohort_id: notify.data("cohort-id")
        }
        success: (json_data) ->
        console.log "this shit returned success"
  notify_pairs()

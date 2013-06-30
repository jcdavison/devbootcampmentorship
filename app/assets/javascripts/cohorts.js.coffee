$ ->
  notify_pairs = ->
    notify = $("#notify_pairs")
    notify.click ->
      console.log "notify clicked"
      $.ajax
        type: "POST"
        url: "/notify"
        data: {
          cohort_id: notify.data("cohort-id")
        }
        success: (json_data) ->
        console.log "this returned success"
  notify_pairs()

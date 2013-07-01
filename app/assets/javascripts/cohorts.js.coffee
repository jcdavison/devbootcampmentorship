$ ->
  notify_pairs = ->
    notify = $("#notify_pairs")
    notify.click ->
      console.log "notify clicked"
      $.ajax
        type: "POST"
        url: "/notify.json"
        data: {
          cohort_id: notify.data("cohort-id")
        }
        success: (data) ->
          console.log "success triggered"
          console.log data
  notify_pairs()

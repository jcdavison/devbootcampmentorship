$ ->
  notify_pairs = ->
    notify = $("#notify_pairs")
    notify.click ->
      console.log "notify clicked"
      $.ajax
        type: "GET"
        url: "/notify.json"
        data: {
          cohort_id: notify.data("cohort-id")
        }
        success: () ->
          console.log "success triggered"
  notify_pairs()

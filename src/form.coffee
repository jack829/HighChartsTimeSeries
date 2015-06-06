window.app = 
  init: ->
    console.log "initing"
    app.form = document.getElementById 'new_point';
    app.form.addEventListener "submit", app.updateChart
    return
  
  updateChart: (event) ->
    event.preventDefault()
    num_reqs = document.getElementById("requests").value
    date = document.getElementById("date").value
    radios = document.getElementsByName("req_type")
    selected = button for button in radios when button.checked
    selected_type = selected.value
    return



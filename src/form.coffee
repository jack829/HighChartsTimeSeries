window.ChartForm = 
  init: ->
    console.log "initialize form"
    document.getElementById('new_point').addEventListener("submit", ChartForm.updateChart)
    return
  
  updateChart: (event) ->
    event.preventDefault()
    num_reqs = document.getElementById("requests").value
    date = document.getElementById("date").value
    radios = document.getElementsByName("req_type")
    selected = button for button in radios when button.checked
    selected_type = selected.value
    Data.updateData num_reqs, date, selected_type
    return



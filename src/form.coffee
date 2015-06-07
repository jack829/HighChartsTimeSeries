window.ChartForm = 
  init: ->
    ChartForm.form = document.getElementById 'new_point'
    ChartForm.form.addEventListener 'submit', ChartForm.updateChart
    return
  
  updateChart: (event) ->
    event.preventDefault() || 
    num_reqs = document.getElementById('requests').value
    date = document.getElementById('date').value
    regex = /^\d{4}[-/]\d{2}[-|/]\d{2}$/
    if not regex.test date
        alert "please enter date in the format yyyy-mm-dd"
        return
    radios = document.getElementsByName('req_type')
    selected = button for button in radios when button.checked
    request_type = selected.value
    Data.updateData num_reqs, date, request_type
    ChartForm.form.reset()
    return



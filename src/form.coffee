window.ChartForm = 
  init: ->
    ChartForm.form = document.getElementById 'new_point_form'
    ChartForm.form.addEventListener 'submit', ChartForm.updateChart
    return
  
  updateChart: (event) ->
    event.preventDefault() 
    
    num_reqs = ChartForm.confirmNumber parseInt document.getElementById('requests').value
    
    date = ChartForm.checkAndConvertDateInput document.getElementById('date').value
    
    radios = document.getElementsByName('req_type')
    selected = button for button in radios when button.checked
    request_type = selected.value
    
    Chart.updateData request_type, date, num_reqs
    ChartForm.form.reset()
    return

  checkAndConvertDateInput: (date) ->
    date_format = /^\d{4}[-]\d{2}[-]\d{2}$/
    if not date_format.test date
        alert "please enter date in the format yyyy-mm-dd"
        return
    return Data.dateConverter date

  confirmNumber: (num) ->
    if not typeof num == 'number'
      alert 'please enter "Number of Requests" as a valid number'
      return
    num


window.document.addEventListener 'DOMContentLoaded', ->
    ChartForm.init()
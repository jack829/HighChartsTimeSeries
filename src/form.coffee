# add event listener for DOM content loaded before loading the module
window.document.addEventListener 'DOMContentLoaded', ->
    ChartForm.init()
    s
#the form module handles form submissions
window.ChartForm = 
  init: ->
    # set an event listener on the form being submitted
    ChartForm.form = document.getElementById('new_point_form').querySelector('FORM')
    ChartForm.form.addEventListener 'submit', ChartForm.updateChart
    return
  
  updateChart: (event) ->
    # prevent submit's default actions such as reloading the page
    event.preventDefault() 
    # get the number of requests submitted in the form, turn the value into an integer and pass it to
    # my format checker to ensure it is a number
    num_reqs = ChartForm.confirmNumber parseInt document.getElementById('requests').value
    # same idea as above, get the date and make sure it is in an acceptable format with my checker function
    # the checker will send the input to the date converter function on the Data module and return that value
    date = ChartForm.checkAndConvertDateInput document.getElementById('date').value
    # get the value of the checked radio button to determine which time series the point will be plotted on
    radios = document.getElementsByName('req_type')
    selected = button for button in radios when button.checked
    request_type = selected.value
    # call the Chart module's update data method to plot the point
    Chart.updateData request_type, date, num_reqs
    #clear the form
    ChartForm.form.reset()
    return

  # this method makes sure that the date was submitted in yyyy-mm-dd format, then passes it to the date 
  # date converter
  checkAndConvertDateInput: (date) ->
    date_format = /^\d{4}[-]\d{2}[-]\d{2}$/
    if not date_format.test date
        alert "please enter date in the format yyyy-mm-dd"
        return
    return Data.dateConverter date

  # this method simply checks that the value passed for requests is a number
  confirmNumber: (num) ->
    if not typeof num == 'number'
      alert 'please enter "Number of Requests" as a valid number'
      return
    num


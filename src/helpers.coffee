# The data module loads the data and has the date converter
window.Data = 
  #upon initialization, the Data module reads in all of the provided data from the json file
  init: ->
    Data.loadData Data.parseData
  #this method creates an XMLHttp request that sends a get request for the data that resides in the 
  # root directory in the domain_reqs.json file. The object listens for ready state changes and 
  # waits for its readyState property to reach 4 signifying that it is done reading all of the data 
  # before executing the callback on it's responseText
  loadData: (callback) ->
    xobj = new XMLHttpRequest();
    xobj.overrideMimeType 'application/json'
    xobj.open 'Get', 'domain_reqs.json', true
    xobj.onreadystatechange = ->
      if (xobj.readyState == 4 and xobj.status == 200)
        callback xobj.responseText
      return
    xobj.send null
    return
  # The data returned from the XMLHttpRequest is a JSON string and therefore is parsed with JSON.parse 
  # subsequently calls the Chart module's data-distrubution function, passing the array of objects that will
  # populate the timeseries chart. 
  parseData: (response) ->
    jsonData = JSON.parse response
    reqsArr = jsonData.categorized_domain_requests
    Chart.distributeData reqsArr
    return

  # this is the date converter which takes a string in the format yyyy-mm-dd and converts it with the Date.UTC
  # method, to millesecionds in a Date object since Jan, 1, 1970. 
  dateConverter: (date) ->
    date = date.replace(/[-]/g, '')
    year = parseInt date.substring 0,4
    month = parseInt date.substring 4,6
    day = parseInt date.substring 6,8

    date = Date.UTC year, month-1, day
    date
#initialize the module
window.Data.init()






window.Data = 
  init: ->
    console.log "Getting data"
    Data.loadData (response) ->
      jsonData = JSON.parse response
      reqsArr = jsonData.categorized_domain_requests
      Chart.distributeData reqsArr
      return

  loadData: (callback) ->
    xobj = new XMLHttpRequest();
    xobj.overrideMimeType "application/json"
    xobj.open 'Get', 'domain_reqs.json', true
    xobj.onreadystatechange = ->
      if (xobj.readyState == 4 and xobj.status == 200)
        callback xobj.responseText
      return
    xobj.send null
    return

  dateConverter: (date) ->
    date = date.replace(/[-]/g, '')
    year = parseInt date.substring 0,4
    month = parseInt date.substring 4,6
    day = parseInt date.substring 6,8

    date = Date.UTC year, month-1, day
    date

window.Data.init()






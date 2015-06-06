window.Data = 
  summary_dates: []
  good_bot_total: []
  bad_bot_total: []
  whitelist_total: []
  human_total: []

  init: ->
    console.log "Getting data"
    Data.loadData (response) ->
      jsonData = JSON.parse response
      reqsArr = jsonData.categorized_domain_requests
      Data.distributeData reqsArr
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

  distributeData: (data) ->
    i = 0
    while i < data.length
      Data.summary_dates.push data[i]["summary_date"]
      Data.good_bot_total.push data[i]["good_bot_total"]
      Data.bad_bot_total.push data[i]["bad_bot_total"]
      Data.whitelist_total.push data[i]["whitelist_total"]
      Data.human_total.push data[i]["human_total"]
      i++
    Chart.renderChart()
    return

  updateData: (number, date, type) ->
    console.log "new date #{date}"
    console.log "summary_dates 0 #{Data.summary_dates[0]}"
    Data.insertDateAndGetIndex date, number, type, Data.insertRequestNumber
    return

  insertDateAndGetIndex: (date, num, type, cb) ->
    index = Data.summary_dates.indexOf(date)
    if index >= 0
      cb index, num, type, true
    else
      Data.summary_dates.push date
      Data.summary_dates.sort (a,b) ->
        parseInt(a.replace(/-/g,'')) - parseInt(b.replace(/-/g,''))
      index = Data.summary_dates.indexOf(date)
      console.log "Data.summary_dates #{Data.summary_dates}"
      cb index, num, type, false

  insertRequestNumber: (index, num, type, replace) ->
    console.log "index #{index}"
    console.log "num #{num}"
    console.log "type #{type}"
    console.log "replace #{replace}"
    num = parseInt num
    if type == "human_total"
      if replace then Data.human_total.splice index, 1, num else Data.human_total.splice index, 0, num
      console.log "human total #{Data.human_total}"
      console.log "type of data #{typeof Data.human_total[0]}, #{typeof Data.human_total[1]}"
    else if type == "good_bot_total"
      if replace then Data.good_bot_total.splice index, 1, num else Data.good_bot_total.splice index, 0, num
    else if type == "bad_bot_total"
      if replace then Data.bad_bot_total.splice index, 1, num else Data.bad_bot_total.splice index, 0, num
    else if type == "whitelist_total"
      if replace then Data.whitelist_total.splice index, 1, num else Data.whitelist_total.splice index, 0, num
    Chart.renderChart()
    return






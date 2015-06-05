loadJSON = (callback) ->
  xobj = new XMLHttpRequest();
  xobj.overrideMimeType "application/json"
  xobj.open 'Get', 'domain_reqs.json', true
  xobj.onreadystatechange = ->
    if (xobj.readyState == 4 and xobj.status == 200)
      callback xobj.responseText
    return
  xobj.send null
  return

loadJSON (response) ->
  jsonData = JSON.parse response
  reqsArr = jsonData.categorized_domain_requests
  distributeData reqsArr
  return

distributeData = (data) ->
  console.log data.length
  summary_dates = []
  good_bot_total = []
  bad_bot_total = []
  whitelist_total = []
  human_total = []
  i = 0
  while i < data.length
    summary_dates.push JSON.stringify data[i]["summary_date"]
    good_bot_total.push data[i]["good_bot_total"]
    bad_bot_total.push data[i]["bad_bot_total"]
    whitelist_total.push data[i]["whitelist_total"]
    human_total.push data[i]["human_total"]
    i++
  console.log "summary_dates #{summary_dates}"
  loadChart summary_dates, human_total, good_bot_total, bad_bot_total, whitelist_total
  return

loadChart = (summary_dates, human_total, good_bot_total, bad_bot_total, whitelist_total) -> 
  $("#graph").highcharts({
    chart:    
      type: "line"
    title: 
      text: "Request Chart"
    xAxis: 
      categories: summary_dates
      crosshair: true
    yAxis:
      min: 0
      title:
        text: "Number of Requests"
    plotOptions: 
      line:
        dataLabels:
          enabled: false
    series: [
      {
        name: "Human Requests"
        data: human_total
      }
        name: "Good Bot Requests"
        data: good_bot_total
      {
        name: "Bad Bot Requests"
        data: bad_bot_total
      }
      {
        name: "Whitelist Requests"
        data: whitelist_total
      }
    ]
  })

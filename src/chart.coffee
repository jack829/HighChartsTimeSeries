# set up the Chart module which controlls the functionality of the timeseries chart
window.Chart = 
  init: ->
    # initialize sets up the arrays which will store each series' data points. It was much faster to push
    # the data to these arrays and then set them into the chart than to read in each point.
    Chart.human_total = []
    Chart.good_bot_total = []
    Chart.bad_bot_total = []
    Chart.whitelist_total = []
  
  render: ->  
    # set up the chart
    Chart.chart = $('#time_series_chart').highcharts({
      chart:    
        type: 'line'
        # Note i used zoom type rather than incorporating another module to break the axes
        zoomType: 'y'
      title: 
        text: 'Request Chart'
      xAxis: 
        type: 'datetime'
        crosshair: true
      yAxis:
        min: 0
        title:
          text: 'Number of Requests'
      plotOptions: 
        line:
          dataLabels:
            enabled: false
      series: [
        {
          name: 'Human Requests'
          data: Chart.human_total
        }
          name: 'Good Bot Requests'
          data: Chart.good_bot_total
        {
          name: 'Bad Bot Requests'
          data: Chart.bad_bot_total
        }
        {
          name: 'Whitelist Requests'
          data: Chart.whitelist_total
        }
      ]
    })
    
  #this method loops through the parsed data, sends each date to be converted to UTC form that works
  # best for Highcharts, then pushes the tuple of date and number of requests for each request type
  # to the corresponding arrays. Then the function calls render to actually render the graph with the
  # data.
  distributeData: (data) ->
    i = 0
    while i < data.length
      date = Data.dateConverter data[i]["summary_date"]
      Chart.human_total.push [date, data[i]["human_total"]]
      Chart.good_bot_total.push [date, data[i]["good_bot_total"]]
      Chart.bad_bot_total.push [date, data[i]["bad_bot_total"]]
      Chart.whitelist_total.push [date, data[i]["whitelist_total"]]
      i++
    Chart.render()
    return

  # this method recruited to either add or update a data point. It first passes the type, which is passed from 
  # the input form, to the Check type, which returns the correct series in the highchart. Then the method checks
  # if the date form the input form already exists on the chart for that series. If the date exists, the method 
  # overwrites the request number for that series. If the date does not exist, the method plots a new point on
  # the selected series at the appropriate coordinates
  updateData: (type, date, num) ->
    series_num = Chart.checkType type    
    chart = Chart.chart.highcharts()
    date_index = chart.series[series_num].xData.indexOf date
    if date_index >= 0 then chart.series[series_num].data[date_index].update(num) else 
      chart.series[series_num].addPoint([date, num])

  checkType: (type) ->
    series_num = 
      if type == "human_total" then 0 
      else if type == "good_bot_total" then 1 
      else if type == "bad_bot_total" then 2
      else if type == "whitelist_total" then 3
    series_num

# initiallize the module 
window.Chart.init()

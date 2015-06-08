window.Chart = 
  init: ->
    Chart.categories = []
    Chart.human_total = []
    Chart.good_bot_total = []
    Chart.bad_bot_total = []
    Chart.whitelist_total = []
  
  render: ->  
    Chart.chart = $('#time_series_chart').highcharts({
      chart:    
        type: 'line'
        zoomType: 'y'
      title: 
        text: 'Request Chart'
      xAxis: 
        type: 'datetime'
        # categories: Chart.categories
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
    chart = Chart.chart.highcharts()
    console.log "x axis #{chart.series[0].xData}"
    console.lo

  distributeData: (data) ->
    i = 0
    while i < data.length
      Chart.human_total.push([Data.dateConverter(data[i]["summary_date"]), data[i]["human_total"]])
      Chart.good_bot_total.push([Data.dateConverter(data[i]["summary_date"]), data[i]["good_bot_total"]])
      Chart.bad_bot_total.push([Data.dateConverter(data[i]["summary_date"]), data[i]["bad_bot_total"]])
      Chart.whitelist_total.push([Data.dateConverter(data[i]["summary_date"]), data[i]["whitelist_total"]])
      i++
    Chart.render()
    return

  checkType: (type) ->
    series_num = 
      if type == "human_total" then 0 
      else if type == "good_bot_total" then 1 
      else if type == "bad_bot_total" then 2
      else if type == "whitelist_total" then 3
    series_num

  updateData: (type, date, num) ->
    series_num = Chart.checkType type    
    chart = Chart.chart.highcharts()
    date_index = chart.series[series_num].xData.indexOf date
    if date_index >= 0 then chart.series[series_num].data[date_index].update(num) else 
      chart.series[series_num].addPoint([date, num])

window.Chart.init()

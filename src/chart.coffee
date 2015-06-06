window.Chart = 

  renderChart: ->
    $('#time_series_chart').highcharts({
      chart:    
        type: "line"
        zoomType: "y"
      title: 
        text: "Request Chart"
      xAxis: 
        categories: Data.summary_dates
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
          data: Data.human_total
        }
          name: "Good Bot Requests"
          data: Data.good_bot_total
        {
          name: "Bad Bot Requests"
          data: Data.bad_bot_total
        }
        {
          name: "Whitelist Requests"
          data: Data.whitelist_total
        }
      ]
    })
  

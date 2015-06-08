This Repo displays a Highcharts time series for requests.
You can dynamically update the requests for any of the time series.

###To run:
Clone down the repo

From the root directory, run: 
  ```
  npm install
  ```

This will install command-line CoffeeScript and its compiler. 

To compile the code to JavaScript, run:
  ```
  coffee --compile --output lib src
  ```

Now the Coffeescript code from the src folder is compiled to JS in the lib folder.

From the root directory:
  ```
  python -m SimpleHTTPServer
  ```

Then on your browser, navigate to http://localhost:8000
# Main application file
#   Kicks off the whole show
#
app      = (require 'express')()
port     = process.env.PORT or 8080
mongoose = require 'mongoose'


console.log "\n\nStarting in mode:", app.settings.env

app.config = process.env

mongoose.connection.on 'open', ()->


  # Configuration
  require('./lib/settings').boot(app);


  # Error Handler
  require('./lib/error-handler').boot(app);


  # Bootstrap models
  app.models = {}
  model_loc = __dirname + '/models'
  model_files = (require 'fs').readdirSync model_loc
  model_files.forEach (file) ->
    (require model_loc + '/' + file).boot(app)


  # Bootstrap controllers
  controller_loc = __dirname + '/controllers'
  controller_files = (require 'fs').readdirSync controller_loc
  controller_files.forEach (file) ->
    (require controller_loc + '/' + file)(app)



  # Start the app by listening on <port>
  server = app.listen port
  console.log "Jokudo-signup started on port #{port}"


mongoose.connect app.config.MONGOHQ_URL||'mongo://localhost/test'
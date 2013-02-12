exports = module.exports = (app) ->
  # Home
  app.get '/', (req, res) ->
    res.render 'index'
  app.get '/test', (req, res) ->
    res.json hey: 1
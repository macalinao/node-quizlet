querystring = require 'querystring'
request = require 'superagent'

baseURL = 'https://api.quizlet.com/2.0/'

module.exports = class QuizletAPI
  ###
  Interface to the Quizlet API.
  ###
  constructor: (params) ->
    ###
    Creates a new instance of a Quizlet API accessor.
    ###
    @clientId = if params.clientId? then params.clientId else throw new Error 'Need client ID!'

  get: (resource, params, cb) ->
    ###
    Performs a general GET request against the Quizlet API.
    ###
    params.client_id = @clientId
    request.get(baseURL + resource + '?' + querystring.stringify(params)).end (res) ->
      if res.body.error
        cb true, res.body
      cb null, res.body

  getUser: (username, cb) ->
    ###
    Gets information about the given user.
    ###
    @get "users/#{username}", {}, cb

  getUserSets: (username, cb) ->
    ###
    Gets the sets of the given user.
    ###
    @get "users/#{username}/sets", {}, cb

  getUserFavorites: (username, cb) ->
    ###
    Gets the favorite sets of the given user.
    ###
    @get "users/#{username}/favorites", {}, cb

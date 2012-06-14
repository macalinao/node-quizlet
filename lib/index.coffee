querystring = require 'querystring'

request = require 'superagent'

baseURL = 'https://api.quizlet.com/2.0/'

class QuizletAPI
  ###
  Interface to the Quizlet API.
  ###

  get: (resource, params, cb) ->
    ###
    Gets the given resource.
    ###
    cb {}

  getUser: (username, cb) ->
    ###
    Gets information about the given user.
    ###
    @get "users/#{username}", {}, cb

  getUserSets: (username, cb) ->
    ###
    Gets information about the given user.
    ###
    @get "users/#{username}/sets", {}, cb

exports.Public = class QuizletPublic extends QuizletAPI

  constructor: (@clientId) ->
    ###
    Creates a new Quizlet API interface instance.
    ###

  get: (resource, params, cb) ->
    params.client_id = @clientId
    request.get(baseURL + resource + '?' + querystring.stringify(params)).end (res) ->
      cb res.body

exports.Authed = class QuizletAuthed extends QuizletAPI


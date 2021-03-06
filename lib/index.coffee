querystring = require 'querystring'
request = require 'superagent'

authBaseUrl = 'https://quizlet.com/authorize/'
tokenUrl = 'https://api.quizlet.com/oauth/token'
baseUrl = 'https://api.quizlet.com/2.0/'

module.exports = class QuizletAPI
  ###
  Interface to the Quizlet API.
  ###
  constructor: (params) ->
    ###
    Creates a new instance of a Quizlet API accessor.
    ###
    @clientId = if params.clientId? then params.clientId else throw new Error 'Need client ID!'
    @secret = if params.secret? then params.secret else throw new Error 'Need secret!'
    @redirectUri = if params.redirectUri? then params.redirectUri else throw new Error 'Need Redirect URI!'

  getAuthUrl: (scopes = ['read'], state = 'state') ->
    ###
    Gets an authorize URL to use to auth a user.
    ###
    for scope, i in scopes
      scopes[i] = scope = scope.toLowerCase()
      unless scope in ['read', 'write_set', 'write_group']
        throw new Error "Invalid scope `#{scope}` encountered!"

    params =
      client_id: @clientId
      response_type: 'code'
      scope: escape scopes.join ' '
      state: state
      redirect_uri: @redirectUri

    return authBaseUrl + '?' + querystring.stringify(params)

  requestToken: (code) ->
    ###
    Requests a token from Quizlet.
    ###
    basic = new Buffer(@clientId + ':' + @secret).toString 'base64'

    params =
      grant_type: 'authorization_code'
      code: code
      redirect_uri: @redirectUri

    request.post(tokenUrl)
      .type('form')
      .set('Authorization', 'Basic ' + basic)
      .send()
      .end (res) ->
        if res.body.error
          cb true, res.body
        else
          cb null, res.body

  get: (resource, params, cb) ->
    ###
    Performs a general GET request against the Quizlet API.
    ###
    params.client_id = @clientId
    request.get(baseUrl + resource + '?' + querystring.stringify(params)).end (res) ->
      if res.body.error
        cb true, res.body
      else
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

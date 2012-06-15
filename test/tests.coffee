Quizlet = require '../lib/index'
config = require './config'
url = require 'url'

describe 'QuizletAPI', ->
  beforeEach ->
    # All API calls are assumed to be authenticated.
    @api = new Quizlet clientId: config.clientId

  describe '#getAuthUrl', ->
    it 'should create a new URL based on the client ID', ->
      parse = url.parse @api.getAuthUrl(), true
      parse.query.client_id.should.equal config.clientId

    it 'should space the parameters fed to scope', ->
      parse = url.parse @api.getAuthUrl(['read', 'write_set']), true
      parse.query.scope.should.equal 'read%20write_set'

    it 'should throw an error when an invalid scope parameter is given', ->
      (=> # Finally used the fat arrow.
        @api.getAuthUrl(['read', 'write_foo']))
      .should.throw 'Invalid scope `write_foo` encountered!'

    it 'should correct weirdly cased scope parameters', ->
      parse = url.parse @api.getAuthUrl(['READ', 'Write_Set']), true
      parse.query.scope.should.equal 'read%20write_set'

  describe '#getUser', ->
    it 'should get the details of a user', (done) ->
      @api.getUser 'simplyianm', (err, user) ->
        user.username.should.equal 'simplyianm'
        done()

  describe '#getUserSets', ->
    it 'should get the sets of a user', (done) ->
      @api.getUserSets 'simplyianm', (err, sets) ->
        set.created_by.should.equal 'simplyianm' for set in sets
        done()

  # describe '#getUserFavorites', ->
  #   it 'should get the favorite sets of a user', (done) ->
  #     @api.getUserFavorites 'simplyianm', (err, sets) ->
  #       hasIt = false
  #       for set in sets
  #         if set.name is 'The Classical Greeks' # Love this set
  #           hasIt = true
  #           break
  #       hasIt.should.be.true
  #       done()

Quizlet = require '../lib/index'
config = require './config'

describe 'QuizletAPI', ->
  beforeEach ->
    # All API calls are assumed to be authenticated.
    @api = new Quizlet clientId: config.clientId

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

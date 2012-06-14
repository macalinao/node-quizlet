Quizlet = require '../lib/index'
config = require './config'

describe 'QuizletPublic', ->
  beforeEach ->
    @api = new Quizlet.Public config.clientId

  describe '#getUser', ->
    it 'should get the details of a user', (done) ->
      @api.getUser 'simplyianm', (user) ->
        user.username.should.equal 'simplyianm'
        done()

  describe '#getUserSets', ->
    it 'should get the sets of a user', (done) ->
      @api.getUserSets 'simplyianm', (sets) ->
        set.created_by.should.equal 'simplyianm' for set in sets
        done()

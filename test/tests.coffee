Quizlet = require '../lib/index'
config = require './config'

describe 'QuizletPublic', ->
  describe '#getUser', ->
    beforeEach ->
      @api = new Quizlet.Public config.clientId

    it 'should get the details of a user', (done) ->
      @api.getUser 'simplyianm', (user) ->
        user.username.should.equal 'simplyianm'
        done()

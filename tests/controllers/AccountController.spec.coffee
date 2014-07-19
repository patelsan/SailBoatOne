assert = require('assert')
request = require('supertest')
User = require('../../api/models/User')
Account = require('../../api/models/Account')
#Database = require('sails-memory')
#accountController = require('../../api/Controllers/AccountController') #if we need to do any direct testing on the controller


Sails = require('sails')

# create a variable to hold the instantiated sails server
app = null

# Global before hook
before((done)->
  #Lift Sails and start the server
  Sails.lift({}, (err,sails)->
    app = sails
    done()
  )
  )

# Global after hook
after((done)->
  app.lower(done))


describe 'Account API', ->
  describe 'New Account Creation', ->

#    before((done)->
#      User.destroy().done((err)->
#        Account.destroy().done(done())
#
#    ))

    @baseUrl = 'http://localhost:1337/'
    @newAccount = email: 'someone@somewhere.com'
    it 'should return error if required attributes are missing', (done)=>
      request(this.baseUrl)
      .post('account/provision')
      .send(this.newAccount)
      .end((err, res)->
        throw err if err?
        assert.equal(res.status, 422, 'Response code doesnt match')

        done()
      )

    it 'should create Account and an User', (done)=>
      account = {email: 'sanasanjay@gmail.com', user_name:'Jack Bower', name: 'blueshark'}
      request(this.baseUrl)
      .post('account/provision')
      .send(account)
      .end((err, res)->
        throw err if err?
        console.log res.body
        assert.equal(res.status, 200, 'Success response code doenst match')
        assert.ok(res.body.token, 200, 'Token not returned on account creation.')

      )

      #second attempt with same name should fail
      request(this.baseUrl)
      .post('account/provision')
      .send(account)
      .end((err, res)->
        throw err if err?
        console.log res.body
        assert.equal(res.status, 400, 'Expected error about account name in use.')

        done()
      )
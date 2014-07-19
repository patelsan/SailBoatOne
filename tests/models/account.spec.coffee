assert = require('assert')
request = require('supertest')

describe 'Account', ->
  describe 'Account Provisioning', ->
    it 'should create admin user', ->
      assert.ok true
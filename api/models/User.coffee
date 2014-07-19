User =
  attributes:
    name: type: 'string', required: true
    email: type: 'email', required: true
    is_admin: type: 'boolean', defaultsTo: false

module.exports = User
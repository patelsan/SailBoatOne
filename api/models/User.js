// Generated by CoffeeScript 1.7.1
(function() {
  var User;

  User = {
    attributes: {
      name: {
        type: 'string',
        required: true
      },
      email: {
        type: 'email',
        required: true
      },
      is_admin: {
        type: 'boolean',
        defaultsTo: false
      }
    }
  };

  module.exports = User;

}).call(this);

AccountController =
  view: (req, res)->
    Account.find().exec((err, accounts)=>
      @viewResponse = ''
      if err?
        @viewResponse = 'Sorry, error occurred: ' + err
      else
        accounts.forEach((account)=> @viewResponse += account.name + '<br />')
    )

    res.send(@viewResponse)

  provision:(req, res)->
    if !req.body.email? or !req.body.user_name? or !req.body.name?
      res.send('Required information is missing', 422)
    else
      #Check whether account name already exists
      #Create Account
      #Create User for this Account, flag as Admin
      Account.findOneByName(req.body.name, (err, account)->
        throw err if err?
        if account?
          res.send({message: 'Account with this name already exists, please select different name.'}, 400)
        else
          Account.create({name: req.body.name}, (err, account)->
            throw err if err?
            #create User
            User.create({account: account, is_admin: true, email: req.body.email, name: req.body.name}, (err, user)->
              throw err if err?
              res.send({token: '-top-secret-token-'}, 200)
              #ToDo: also log in the user
            ))
      )



module.exports = AccountController
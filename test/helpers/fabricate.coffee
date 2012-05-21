_ = require 'underscore'

rand4 = -> (((1+Math.random())*0x10000)|0).toString(16).substring(1)
uuid = -> "-#{rand4()}#{rand4()}-#{rand4()}-#{rand4()}-#{rand4()}-#{rand4()}#{rand4()}#{rand4()}"

# A simple javascript object fabricator.
#
# @param {String} type Pass it a type like 'artwork' and it'll return the defaults
# @param {Object} extObj Extend the object with an optional extra object
# @return {Object} The final fabricated object

module.exports = (type, extObj = {}) ->
  _.extend (switch type
    
    when 'msg'
      _id: uuid()
      user_id: uuid()
      body: 'Hello world.'
      created_at: Date.now()
        
  ), extObj
# 
# Requires & runs the tests
# 

glob = require 'glob'

process.env.NODE_ENV = 'test'
require file for file in glob.sync "#{process.cwd()}/test/**/*_spec.coffee"
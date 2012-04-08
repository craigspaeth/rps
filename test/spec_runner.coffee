glob = require 'glob'

require file for file in glob.sync "#{process.cwd()}/test/**/*_spec.coffee"
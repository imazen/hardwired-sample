require 'bundler/setup'
Bundler.require(:default)

require 'debugger'

require 'hardwired'

require './hardwired_meta'

require './site'

require './custom'

run Site


require 'tests.utils'
require 'tests.mocks'
require 'tests.ngcp_xavp'
require 'tests.ngcp_dp'
require 'tests.ngcp_up'
require 'tests.ngcp_pp'
require 'tests.ngcp_rp'
require 'tests.ngcp'
---- Control test output:
lu = LuaUnit
lu:setOutputType( "TAP" )
lu:setVerbosity( 1 )
lu:run()
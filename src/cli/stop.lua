#!/usr/bin/env lua

local constants = require "kong.constants"
local cutils = require "kong.cli.utils"
local signal = require "kong.cli.utils.signal"
local args = require("lapp")(string.format([[
Fast shutdown

Usage: kong stop [options]

Options:
  -c,--config (default %s) configuration file
]], constants.CLI.GLOBAL_KONG_CONF))

-- Check if running, will exit if not
signal.is_running(args.config)

-- Send 'stop' signal (fast shutdown)
if signal.send_signal(args.config, "stop") then
  cutils.logger:success("Stopped")
else
  cutils.logger:error_exit("Could not stop Kong")
end

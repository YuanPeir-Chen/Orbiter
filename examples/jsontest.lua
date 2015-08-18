local orbiter = require 'orbiter'
local text = require 'orbiter.text'
local f = require "function"
local form = orbiter.new()

local json = text.Template [[
    $body
]]
local function make_list(t)
   local append = table.insert
   local res = {}
   append(res,'<ul>')
   for k,v in pairs(t) do
        append(res,('<li>%s = %s</i>'):format(k,v))
   end
   append(res,'</ul>')
   return table.concat(res,'\n')
end

local results2 ='{"Name":"JSON", "Key":"key"}'

function form:results(web)
   -- local vars_list = make_list(web.input) -- for POST; use web.GET for GET
   local headers = make_list(web.vars)
   return json { body = results}
end

form:dispatch_post(form.result2,'/result')

form:run(f.GetIP(), '--ct=application/json')

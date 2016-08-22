#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'mechanize'

# This is just sample program. See the following blog for details.
# http://www.mirandora.com/?p=808
# You don't have to get the token via Agent.
# Use your own browser should be easier.

CLIENT_ID     = ENV['CLIENT_ID']
CLIENT_SECRET = ENV['CLIENT_SECRET']
REDIRECT_URI  = 'localhost'
#AUTH_CODE     = ENV['AUTH_CODE']

# Generate Agent
agent = Mechanize.new
agent.user_agent_alias = 'Windows IE 9'

# Get AUTH_CODE to get ACCESS_TOKEN
url = "https://www.healthplanet.jp/oauth/auth?client_id=#{CLIENT_ID}&redirect_uri=#{REDIRECT_URI}&scope=innerscan&response_type=code"
puts "Access to the following URL:"
puts url
print "Copy and paste AUTH_CODE: "
AUTH_CODE = gets.chop
puts ""

# Get Access Token
page4 = agent.post('https://www.healthplanet.jp/oauth/token', {
                     "client_id"     => CLIENT_ID,
                     "client_secret" => CLIENT_SECRET,
                     "redirect_uri"  => REDIRECT_URI,
                     "code"          => AUTH_CODE,
                     "grant_type"    => "authorization_code"
                   })

puts "ACCESS_TOKEN: "
puts JSON.parse(page4.body)
#ACCESS_TOKEN = access_array["access_token"]

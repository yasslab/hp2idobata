#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# This is just sample program. See the following blog for details.
# http://www.mirandora.com/?p=808
# You don't have to get the token via Agent.
# Use your own browser should be easier.

# Generate Agent
agent = Mechanize.new
agent.user_agent_alias = 'Windows IE 9'


# Get Access Code
#url = "https://www.healthplanet.jp/oauth/auth?client_id=#{CLIENT_ID}&redirect_uri=#{REDIRECT_URI}&scope=innerscan&response_type=code"
#puts "URL: " + url
#page = agent.get(url)
#login_form = page.forms_with(:name => 'login.LoginForm').first
#login_form.fields_with(:name => 'loginId').first.value = ENV['USER_ID']
#login_form.fields_with(:name => 'passwd' ).first.value = ENV['USER_PASS']
#page2 = login_form.click_button

#login_form2 = page2.forms_with(:name => 'common.SiteInfoBaseForm').first
#login_form2.fields_with(:name => 'approval').first.value = 'true'
#page3 = login_form2.click_button
#puts "page3: " + page3

#AUTH_CODE = page3.uri.query[5,page3.uri.query.length - 5]
#puts "AUTH_CODE: " + AUTH_CODE


# Get Access Token
#page4 = agent.post('https://www.healthplanet.jp/oauth/token', {
#                     "client_id"     => CLIENT_ID,
#                     "client_secret" => CLIENT_SECRET,
#                     "redirect_uri"  => REDIRECT_URI,
#                     "code"          => AUTH_CODE,
#                     "grant_type"    => "authorization_code"
#                   })
#access_array = JSON.parse(page4.body)
#ACCESS_TOKEN = access_array["access_token"]

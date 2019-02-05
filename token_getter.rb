#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'mechanize'
require 'pry'
require 'json'

# This is just sample program. See the following blog for details.
# http://www.mirandora.com/?p=808
# You don't have to get the token via Agent.
# Use your own browser should be easier.

CLIENT_ID     = ENV['CLIENT_ID']
CLIENT_SECRET = ENV['CLIENT_SECRET']
REDIRECT_URI  = 'https://www.healthplanet.jp/success.html'

# Generate Agent
agent = Mechanize.new
agent.user_agent_alias = 'Windows IE 9'

# ここにアクセスする

# Get AUTH_CODE to get ACCESS_TOKEN
url = "https://www.healthplanet.jp/oauth/auth?client_id=#{CLIENT_ID}&redirect_uri=#{REDIRECT_URI}&scope=innerscan&response_type=code"
puts "Access to the following URL:"
puts url
# https://www.healthplanet.jp/success.html?code=aZFP5rVq3P8EaJOelE8l7Olut6WrDM8p6UAihf1MgIm33 のようにAUTH_CODEを取得する
print "Go to this URL and Copy, paste AUTH_CODE: "
AUTH_CODE = gets.chop
puts ""

# Get Access Token
agent.post('https://www.healthplanet.jp/oauth/token', {
  "client_id"     => CLIENT_ID,
  "client_secret" => CLIENT_SECRET,
  "redirect_uri"  => REDIRECT_URI,
  "code"          => AUTH_CODE,
  "grant_type"    => "authorization_code"
})
page4 = agent.post('https://www.healthplanet.jp/oauth/token.', {
                     "client_id"     => CLIENT_ID,
                     "client_secret" => CLIENT_SECRET,
                     "redirect_uri"  => REDIRECT_URI,
                     "code"          => AUTH_CODE,
                     "grant_type"    => "authorization_code"
                   })

puts "ACCESS_TOKEN: "
access_array =  JSON.parse(page4.body)
puts access_array["access_token"]

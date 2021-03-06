#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'idobata'
require 'mechanize'
require 'nokogiri'
require 'json'
require 'csv'
require 'pry'

Idobata.hook_url = ENV['IDOBATA_END']
ACCESS_TOKEN     = ENV['ACCESS_TOKEN']
LABEL_COLOR      = ENV['LABEL_COLOR'] || "label-success"
# cf. http://qiita.com/harukasan/items/2ddb47f7ce6086d3a571#2-1

# Required to generate ACCESS_TOKEN
# See `sample_token_getter.rb` for details.
#REDIRECT_URI  = 'localhost'
#CLIENT_ID     = ENV['CLIENT_ID']
#CLIENT_SECRET = ENV['CLIENT_SECRET'],
#AUTH_CODE = ENV['AUTH_CODE']


TAG          = 6021,6022,6023,6026,6027,6028
TAG2NAME     = {
  '6021' => '体重', '6022' => '体脂肪率', '6023' => '筋肉量', '6024' => '筋肉スコア',
  '6025' => '内臓脂肪レベル', '6026' => '内臓脂肪レベル', '6027' => '基礎代謝量',
  '6028' => '体内年齢', '6029' => '推定骨量' }
TAG2UNIT     = {
  '6021' => 'kg', '6022' => '%', '6023' => 'kg', '6024' => '点',
  '6025' => 'レベル', '6026' => 'レベル', '6027' => 'kcal',
  '6028' => '歳', '6029' => 'kg' }
TAG_PARAMS   = 6
DATE_TYPE    = 0
FROM_DATE    = (Time.now - 60*60).strftime("%Y%m%d%H%M%S")
TO_DATE      = Time.now.strftime("%Y%m%d%H%M%S") # in the last 60 minutes
#FROM_DATE    = "20160114000000"  # Sample Date Format
#TO_DATE      = "20160114235900"  # Sample Date Format

# Generate agent and get data via ACCESS_TOKEN
agent = Mechanize.new
agent.user_agent_alias = 'Windows IE 9'

url = "https://www.healthplanet.jp/status/innerscan.xml?access_token=#{ACCESS_TOKEN}&date=#{DATE_TYPE}&tag=#{TAG}&from=#{FROM_DATE}&to=#{TO_DATE}"
result  = agent.get(url)
doc     = Nokogiri::HTML.parse(result.body.toutf8)
data    = doc.xpath("//data")
date    = doc.xpath("//date")
keydata = doc.xpath("//keydata")
tags    = doc.xpath("//tag")


if data.empty?
  puts "Nothing found in the last hour."
  exit
end

# Generate message to send Idobata
msg = ""
msg << "<span class='label #{LABEL_COLOR}'>yasulab</span> が体重を測りました<br /> \n"
msg << "日付: " + DateTime.parse(date[0]).strftime("%Y年%m月%d日 %H:%M:%S") + "<br/> \n"
data.each_with_index { |datum, num|
  break if num >= 1 and TAG2NAME[tags[num].text] == "体重"  # Get the latest only
  next  if tags[num].nil? # The nexts are fixed data: <height>172</height>  <sex>male</sex>
  msg << TAG2NAME[tags[num].text]
  msg << ": "
  msg << keydata[num].text + TAG2UNIT[tags[num].text]
  msg << " <br/> \n"
}

puts msg

# Send the message as HTML
Idobata::Message.create(source: msg, format: :html) unless msg.empty?

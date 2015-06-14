#!/usr/bin/env ruby

require 'json'

settings = JSON.parse(STDIN.read)
p settings

# Send to mackerel
epoch = Time.now.to_i
api_key = ENV['MACKEREL_API_KEY']
json = [
  {
    name: 'myself.sleep',
    time: epoch,
    value: settings['sleep'].to_i,
  },
  {
    name: 'myself.home',
    time: epoch,
    value: settings['home'].to_i,
  },
  {
    name: 'myself.time_to_sleep',
    time: epoch,
    value: settings['time_to_sleep'].to_i,
  },
].to_json
`curl https://mackerel.io/api/v0/services/My-Room/tsdb -H 'X-Api-Key: #{api_key}' -H 'Content-Type: application/json' -X POST -d '#{json}'`

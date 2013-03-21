require "rubygems"
require "bundler"
Bundler.require :default, (ENV["RACK_ENV"] || "development").to_sym

get "/" do
  cache_control :public, max_age: 300  # 5 mins.
  "Hello world at #{Time.now}!"
end

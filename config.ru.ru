require "rubygems"
require "bundler"
Bundler.require :default, (ENV['RACK_ENV'] || "development").to_sym

require "./scraper"
require "./generator"

set :views, -> { root }

TITLE = "Demo of caching thingy"

get '/' do
  @title = TITLE
  slim :index
end

get %r{/(.+)} do
  data = Scraper.new(request.fullpath).scrape
  root = "http://#{request.host_with_port}"
  url = request.url
  atom = Generator.new(data, name: TITLE, root: root, url: url).to_atom

  content_type "application/atom+xml"
  cache_control :public, max_age: 300 # 30 mins.
  atom
end
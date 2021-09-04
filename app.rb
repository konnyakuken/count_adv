require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models/count.rb'

before do
  if Count.all.size == 0
    Count.create(number: 0)
  end
end

get '/' do
  @number = Count.first.number
   erb :index
end

get '/count' do
  @number = Count.first.number
  erb :index
end

post '/plus' do
  count = Count.first
  count.number = count.number + 1
  count.save
  redirect '/count'
end

post '/minus' do
  count = Count.first
  count.number = count.number - 1
  count.save
  redirect '/count'
end

post "/clear" do
  count=Count.first
  count.number=0
  count.save
  redirect "/count"
end
require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models/count.rb'

enable :sessions

before do
  if Count.all.size == 0
    Count.create(number: 0)
  end

  
end

get '/' do
  Count.all.size.times do |n|#カラムの数だけ回す
  eval("@number#{n+1}= Count.find(#{n+1}).number") 
  end
   erb :index
end

get '/count' do
  Count.all.size.times do |n|
  eval("@number#{n+1}= Count.find(#{n+1}).number") #動的に今ある分だけ変数の生成
  end
  erb :index
end

post '/plus/:id' do
  count = Count.find(params[:id])
  count.number = count.number + 1
  count.save
  redirect '/count'
end

post '/minus/:id' do
  count = Count.find(params[:id])
  count.number = count.number - 1
  count.save
  redirect '/count'
end

post "/clear/:id" do
  count=Count.find(params[:id])
  count.number=0
  count.save
  redirect "/count"
end


post"/new"do
    Count.create(number: 0)
  redirect "/count"
end

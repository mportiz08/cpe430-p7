require 'rubygems'
require 'sinatra'
require 'erb'

module App
  get '/' do
    erb :index
  end
  
  get '/question/:id' do
    erb :question
  end
end

require 'rubygems'
require 'sinatra'
require 'erb'
require 'data_mapper'

module App
  get '/' do
    erb :index
  end
  
  get '/question/:id' do
    erb :question
  end
end

require 'rubygems'
require 'sinatra'
require 'erb'

module App
  get '/' do
    erb :index
  end
end

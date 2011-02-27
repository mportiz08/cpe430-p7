require 'rubygems'
require 'sinatra'
require 'erb'
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Question
  include DataMapper::Resource
  
  property :id,              Serial
  property :text,            String
  property :answer,          String
  property :total_correct,   Integer
  property :total_incorrect, Integer
end

DataMapper.auto_upgrade!

get '/' do
  erb :index
end

get '/question/:id' do
  erb :question
end

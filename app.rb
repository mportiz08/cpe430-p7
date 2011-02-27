require 'rubygems'
require 'sinatra'
require 'erb'
require 'data_mapper'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Question
  include DataMapper::Resource
  
  property :id,              Serial
  property :text,            String, :required => true
  property :answer,          String, :required => true
  property :total_correct,   Integer, :default => 0
  property :total_incorrect, Integer, :default => 0
end

DataMapper.auto_upgrade!

get '/' do
  erb :index
end

get '/question/:id' do
  erb :question
end

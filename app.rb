require 'rubygems'
require 'sinatra'
require 'erb'
require 'data_mapper'

enable :sessions

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
  
  def show_answer(actual, expected)
    klass = "good"
    klass = "bad" unless actual == expected
    "<span class=\"#{klass}\">#{h actual}</span>"
  end
end

class Question
  include DataMapper::Resource
  
  property :id,              Serial
  property :text,            String, :required => true
  property :answer,          String, :required => true
  property :total_correct,   Integer, :default => 0
  property :total_incorrect, Integer, :default => 0
  
  def percent_correct
    total = self.total_correct + self.total_incorrect
    unless total == 0
      "#{((self.total_correct.to_f / total.to_f) * 100).round}%"
    else
      "0%"
    end
  end
end

DataMapper.auto_upgrade!

get '/' do
  @time = Time.now
  erb :index
end

get '/question/:id' do
  @question = Question.get(params[:id])
  erb :question
end

post '/question/:id' do
  @question = Question.get(params[:id])
  session["q#{params[:id]}"] = params[:answer]
  
  if params[:answer] == @question.answer
    @question.total_correct += 1
    @question.save
  else
    @question.total_incorrect += 1
    @question.save
  end
  
  next_id = params[:id].to_i + 1
  unless next_id == 6
    redirect "/question/#{next_id.to_s}"
  else
    redirect "/results"
  end
end

get '/results' do 
  @questions = Question.all
  @answers = session
  erb :results
end

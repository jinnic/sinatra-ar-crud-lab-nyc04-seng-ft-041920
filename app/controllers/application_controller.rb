
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # Read
  get '/' do
    redirect to "/articles"
  end

  # Read
  get '/articles' do
    @articles = Article.all
    erb :index
  end

  # Create
  get '/articles/new' do
    # @article = Article.new
    erb :new
  end

  # Create
  post '/articles' do 
    # binding.pry
    @article = Article.create(title: params[:title],content: params[:content])
    redirect "/articles/#{@article.id}"
  end
  
  # Read
  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  # Update
  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  # patch '/articles/:id' do 
  #   article = Article.update(params[:article])
  #   redirect '/article/#{article.id}'
  # end

  patch "/articles/:id" do
    @article = Article.find(params[:id])
    @article.update(title: params[:title],content: params[:content])
    redirect to "/articles/#{ @article.id }"
  end

  # Delete
  delete '/articles/:id' do 
    Article.destroy(params[:id])
    redirect '/articles'
    # erb :index
  end
end

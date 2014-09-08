require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'pry'
require_relative 'models/contact'

get '/' do
  @contacts = Contact.all
  erb :index
end

get '/:id' do
  id = params[:id]
  @contact = Contact.find_by id: id
  erb :show
end

post '/' do
  queried_name = params['search']

  @contact = Contact.where(first_name: queried_name).first
  @contact = Contact.where(last_name: queried_name).first if @contact.nil?

  redirect '/' if @contact.nil?
  redirect "/#{@contact.id}"
end

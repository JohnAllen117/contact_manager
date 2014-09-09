require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'pry'
require_relative 'models/contact'

get '/' do
  @contacts = Contact.all
  erb :index
end

post '/' do
  queried_name = params['search']

  @contact = Contact.where(first_name: queried_name).first
  @contact = Contact.where(last_name: queried_name).first if @contact.nil?

  redirect '/' if @contact.nil?
  redirect "/contacts/#{@contact.id}"
end

get '/contacts/:id' do
  id = params[:id]
  @contact = Contact.find_by id: id
  erb :"contacts/show"
end

get '/new_contact' do
  erb :new_contact
end

post '/new_contact' do
  first_name = params['first_name']
  last_name = params['last_name']
  phone_number = params['phone_number']
  @contact = Contact.find_or_create_by(first_name: first_name, last_name: last_name, phone_number: phone_number)
  redirect '/'
end

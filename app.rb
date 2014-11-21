require 'sinatra'
require 'sequel'

DB = Sequel.connect('sqlite://test.db')

get "/create" do
  DB.create_table :posts do
    primary_key :id
    String :uname
    String :comment
  end
  redirect "/forum"
end
get "/drop" do
  DB.drop_table("posts")
  redirect "/create"
end

get "/forum" do
  @items = DB[:posts] # Create a dataset
  # Print out the records
  @items.all.each do |x|
    puts x[:comment]
  end
  erb :show_comment
end

post "/sub" do
  @items = DB[:posts] # Create a dataset
  #extracts the inputs from the form that are in the params array
  uname=params['uname']
  comment=params['comment']
  #insert the values you get into the appropriate database fields in the posts table
  @items.insert(:uname => uname, :comment => comment)
  redirect "/forum"
end


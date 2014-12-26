get '/' do
  @signup = false;
  erb :grid
end

post '/users/:id/edit' do
  @edited_user = User.update(params[:user])
  redirect "/users/#{@edited_user.id}"
end







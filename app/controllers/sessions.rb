

get '/' do
  redirect_home if authorized?
  # flash[:notice] = "test"
  erb :login
end

post '/login' do

  begin
    user = User.find(username: params[username], email: params[email], password_hash: params[password])
  TODO
  rescue => error
  end

  if error
    flash[:notice] = "Login Error #{error}"
    redirect '/'
  else
    login(new_user)
    redirect_home
  end
end


post '/create_user' do
  begin
    new_user = User.new(username: params[username], email: params[email])
    new_user.password = params[:password]
    new_user.save!
  rescue => error
  end

  if error
    flash[:notice] = "Signup Error #{error}"
    redirect '/'
  else
    login(new_user)
    redirect ("/user/#{new_user.id}")
  end
end

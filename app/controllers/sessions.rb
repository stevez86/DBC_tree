

get '/' do
  redirect_home if authorized?
  # flash[:notice] = "test"
  erb :login
end

post '/login' do

  begin
    @user = User.find_by_username(params[:username])

    if @user.password != params[:password]
      flash[:notice] = "Incorrect Password"
      redirect_home
    end

  rescue => error
  end

  if error
    flash[:notice] = "Login Error #{error}"
    redirect_home
  else
    login(@user)
    redirect_home
  end
end


post '/signup' do
  begin
    new_user = User.new(username: params[:username], email: params[:email])
    new_user.password = params[:password]
    new_user.save!
  rescue => error
  end

  if error
    # case
    flash[:notice] = error
    redirect_home
  else
    login(new_user)
    redirect_home
  end
end

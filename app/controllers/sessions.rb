

get '/' do
  redirect_home if authorized?
  # flash[:notice] = "test"
  erb :login
end

post '/login' do

  begin
    @user = User.find_by_username(params[:username])

    if @user.password != params[:password]
      flash[:login_notice] = "Incorrect password"
      redirect_home
    end

  rescue => error
  end

  if error
    if error.is_a? NoMethodError
      flash[:login_notice] = "Invalid username"
    else
      flash[:login_notice] = "Login Error: #{error}"
    end
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
    flash[:signup_notice] = "#{error.to_s.sub('Validation failed: ','').sub(',',' and')}"
    redirect_home
  else
    login(new_user)
    redirect_home
  end
end

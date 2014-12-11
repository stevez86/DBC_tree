helpers  do

  def authorized?
    !!session[:user_id]
  end

  def login(user)
    session[:user_id] = user.id
    session[:username] = user.name
  end

  def logout
    session.clear
  end

  def username
    session[:username] || "Guest"
  end

  def redirect_home
    if authorized?
      redirect "/user/#{session[:user_id]}"
    else
      redirect '/'
    end
  end
end

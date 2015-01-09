
helpers  do

  def authorized?
    !!session[:user_id]
  end

  def login(user)
    session[:user_id] = user.id
    session[:user_name] = user.name
  end

  def logout
    session.clear
  end

  def current_user_id
    session[:user_id]
  end

  def current_user_name
    session[:user_name]
  end
end

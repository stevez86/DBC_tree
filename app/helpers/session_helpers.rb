
helpers  do

  def site_name
    '#' + (Faker::Company.bs).split.sample(rand(1..3)).map(&:capitalize).join(' ').gsub(/[aeiouy]*$/,'') + "itter"
  end

  def authorized?
    !!session[:user_id]
  end

  def login(user)
    session[:user_id] = user.id
    session[:username] = user.username
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

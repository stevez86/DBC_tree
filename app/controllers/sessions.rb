get '/login' do

  if params[:state] == "DCEEFWF45453sdffef424"

    code = params[:code]
    client_id = ENV['API_KEY']
    secret_key = ENV['SECRET_KEY']
    redirect_url = "http://localhost:9393/login"

    url = "https://www.linkedin.com/uas/oauth2/accessToken?grant_type=authorization_code&code=#{code}&redirect_uri=#{redirect_url}&client_id=#{client_id}&client_secret=#{secret_key}"

    li_user_token = HTTParty.post(url).parsed_response["access_token"]

    requested_fields = "formatted-name,location,headline,email-address,picture-url"
    header = {headers: { "Authorization" => "Bearer #{user_token}"}}
    url = "https://api.linkedin.com/v1/people/~:(#{requested_fields})"
    response = HTTParty.get(url, header).parsed_response["person"]

    li_email = response["email_address"]

    new_li_user = LinkedIN.find_or_create_by(email: li_email)
    new_li_user.name = response["formatted-name"]
    new_li_user.location = response["location"]["name"]
    new_li_user.headline = response["headline"]
    new_li_user.picture_url = response["picture_url"]
    new_li_user.token = li_user_token
    new_li_user.user = User.find_by(email: li_email)
    new_li_user.save!
    ap "TEST"
    ap new_li_user

    # ap response

    redirect '/success'
  end


  erb :login
end

get '/login-redirect' do

  client_id = ENV['API_KEY']
  scope = "r_fullprofile%20r_emailaddress%20r_basicprofile%20r_contactinfo"
  state = "DCEEFWF45453sdffef424"
  redirect_url = "http://localhost:9393/login"

  redirect "https://www.linkedin.com/uas/oauth2/authorization?response_type=code&client_id=#{client_id}&scope=#{scope}&state=#{state}&redirect_uri=#{redirect_url}"

end

get '/login-redirect-auth' do
  params["code"]
end

get '/logout' do
  logout
  redirect '/login'
end

# post '/signup' do

#   begin
#     new_user = User.new(username: params[:username], email: params[:email])
#     new_user.password = params[:password]
#     new_user.save!
#   rescue => error
#   end

#   if error
#     flash[:signup_notice] = "#{error.to_s.sub('Validation failed: ','').sub(',',' and')}"
#     redirect_home
#   else
#     login(new_user)
#     redirect_home
#   end
# end

require 'pry'
helpers do

	def current_user
		@current_user = User.find_by(id:session[:user_id]) if session[:user_id]
		
	end
	
end

before do
  redirect '/login' if !current_user && request.path != '/login' && request.path != '/signup'
end

 # Homepage (Root path)
# get '/' do
#   erb :index
# end

get '/login' do
    erb :login_signup
end


get '/profile' do
	
	erb :profile
end

get '/signup' do
	erb :login_signup
end

get '/pins' do
	
    erb :pins
end

get '/pins/new' do

end
get '/pins/delete' do

end

get '/pins/:id' do
	erb :profile
end

get '/login/:id' do
	@user = User.find(params [:id])
	erb :profile
end

get '/profile/edit' do
	# @user = User.find(session[:user_id])
	erb :profile
end

get '/' do
    @pins = Pin.all.reverse
    erb :index
end

post '/profile/edit' do


	user = User.find_by(email: params[:email])
 	email = params[:email]
    password = params[:password]

	profile = current_user.update(email: params[:email], password: params[:password])
	
	redirect '/'

end

# post 

post '/login' do

	@user = User.find_by(email: params[:email])

	if @user.password == params[:password]
    	session[:user_id] = @user.id
    	redirect 'profile'
    else
    	redirect '/'
    end
end

post '/logout' do
	session[:user_id] = nil
	redirect '/'
end

post '/profile' do 
	@user = User.find(session[:user_id])
	redirect '/'
end

post '/signup' do
	user = User.find_by(email: params[:email])
	if user
		redirect '/login'
	end
	user = User.new(username: params[:username], email: params[:email], password: params[:password])
	user.save

	redirect '/'

end	



post '/pins/new' do
  	title = params[:title]
    image = params[:image]
    text = params[:text]

 if title == "" 	
    redirect "/"
    end

 if text == "" 	
    redirect "/"
    end

    if image == "" 	
    redirect "/"
    end

    pin = current_user.pins.create(title: params[:title], image: params[:image], text: params[:text]) 
    redirect "/pins/#{pin.id}"

   
    
end

# post "/pins/delete" do
# 	# id = params[:pinid]

# 	# pin = Pin.find(id)
# 	# pin.destroy

# 	pin = current_user.pins
# 	pin = Pin.find(current_user.pin.id)
# 	pin.destroy


# 	redirect '/profile'
# end

delete "/pins/delete" do
	id = params[:id]

  pin = Pin.find(id)
  pin.delete
  redirect '/profile'
end




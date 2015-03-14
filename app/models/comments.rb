class Comments < ActiveRecord::Base
	
	belongs_to :pin
	belong_to :user

end
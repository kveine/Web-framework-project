class Feed < ActiveRecord::Base
	belongs_to 	:user
	has_many	:recipes
	has_many 	:followings
end

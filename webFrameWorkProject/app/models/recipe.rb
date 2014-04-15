class Recipe < ActiveRecord::Base
	belongs_to 	:feed
	belongs_to	:category
	has_many 	:favourites

	has_attached_file :avatar, :styles => { :small => "200x200>", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/Koala.jpg"
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  	do_not_validate_attachment_file_type :avatar

end

class User < ActiveRecord::Base
	
	has_one 	:feed
	has_many 	:followings
	has_many 	:favourites

	attr_accessor 	:password
	
  	has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  	do_not_validate_attachment_file_type :avatar

	validates :email,		presence: true, uniqueness: true,
							format: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :firstname, 	presence: true, 
							length: { in: 2..40}


	validates :surname, 	presence: true, 
							length: { in: 2..40}

	validates :password, 	presence: true, 
							length: {in: 8..20},
							confirmation: true

	

	before_save :encrypt_password

	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end

	class << self
		def authenticate(email, submitted_password)
			user = find_by_email(email)
			return nil if user.nil?
			return user if user.has_password?(submitted_password)
			#(user && user.has_password?(submitted_password) ? user :nil)
			
		end
	end

	private
		def encrypt_password
			self.salt = make_salt if new_record?
			self.encrypted_password = encrypt(password)
		end

		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end

		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end

		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end

	
end
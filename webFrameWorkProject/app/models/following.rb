class Following < ActiveRecord::Base
	belongs_to :user
	belongs_to :feed

	validates 	:feed_id, presence: true, uniqueness: { scope: :user_id }
end

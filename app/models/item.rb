class Item < ActiveRecord::Base
	validates :name, :presence => true

	has_many :investments

	def rating_by_user(user)
		10 #TODO: calc investment size of user in this item
	end
end

class Item < ActiveRecord::Base
	validates :name, :presence => true

	has_many :investments, :dependent => :destroy

	attr_accessible :worth

	def investment_of(user)
		self.investments.where(:user_id => user).first
	end
end

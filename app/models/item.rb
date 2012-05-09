class Item < ActiveRecord::Base
	validates :name, :presence => true
	validates_each :worth, :pos_market_height do |record, attr, value|
		if value < 0
			record.errors.add(attr, attr + " cannot be negative")
		end
	end


	has_many :investments, :dependent => :destroy

	attr_accessible :name, :description, :worth

	def investment_of(user)
		self.investments.where(:user_id => user).first
	end
end

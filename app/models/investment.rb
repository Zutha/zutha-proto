class Investment < ActiveRecord::Base
	belongs_to :user
	belongs_to :item

	K = 1.5

	def buy(amount)
		h0 = item.pos_market_height
		h1 = (h0**K + amount)**(1/K)
		dh = h1 - h0

		item.transaction do
			user.spend(amount)
			self.h += dh
			item.worth += amount
			item.pos_market_height = h1
			item.save!
			self.save!
		end
	end

	def sell(amount)
		h0 = item.pos_market_height
		h1 = (h0**K - amount)**(1/K)
		dh = h0 - h1

		item.transaction do
			user.receive(amount)
			self.h -= dh
			item.worth -= amount
			item.pos_market_height = h1
			item.save!
			self.save!
		end
	end

	def value
		h0 = item.pos_market_height
		h1 = h0 - self.h
		v0 = h0**K
		v1 = h1**K
		v = v0 - v1
		v
	end
end

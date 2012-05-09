class Investment < ActiveRecord::Base
	belongs_to :user
	belongs_to :item
	
	validates_each :h do |record, attr, value|
		if value < 0
			record.errors.add(attr, attr + " cannot be negative")
		end
	end

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
		item.errors.empty?
	end

	def sell(amount)
		v = value
		h0 = item.pos_market_height
		if amount >= v
			amount = v
			dh = self.h
			h1 = h0 - dh
		else
			h1 = (h0**K - amount)**(1/K)
			dh = h0 - h1
		end

		item.transaction do
			user.receive(amount)
			self.h -= dh
			item.worth -= amount
			item.pos_market_height = h1
			item.save!
			self.save!
		end
		item.errors.empty?
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

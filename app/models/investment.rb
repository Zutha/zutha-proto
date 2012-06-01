class Investment < ActiveRecord::Base
	include ApplicationHelper

	belongs_to :user
	belongs_to :item
	
	validates_each :h do |record, attr, value|
		if value < 0
			record.errors.add(attr, "%s cannot be negative" % attr)
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
		v = value_hp
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
			item.pos_market_height = h1
			item.worth = (h1**K).round(6)

			item.save!
			self.save!
		end
		item.errors.empty?
	end

	def set_value(value)
		if value <= 0.0 then value = 0.0 end

		old_value = value_hp
		change = value - old_value
		h0 = item.pos_market_height

		item.transaction do
			user.spend(change)
			
			if value == 0 then
				h1 = [h0 - h, 0.0].max
				item.pos_market_height = h1
				self.h = 0
			else
				h1 = [(h0**K + change)**(1/K), 0.0].max
				dh = h1 - h0
				item.pos_market_height = h1
				self.h = (h + dh)
			end
			item.worth = (h1**K).round(6)
			
			item.save!
			self.save!
		end
		item.errors.empty?
	end

	def value_hp
		h0 = item.pos_market_height
		h1 = h0 - self.h
		v0 = h0**K
		v1 = h1**K
		v = v0 - v1
		v
	end

	def value
		pretty_round(value_hp)
	end

end

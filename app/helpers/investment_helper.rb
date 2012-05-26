module InvestmentHelper
	def investment(item)
		investment = item.investment_of current_user
	end
	
	def user_rating(item)
		investment = investment(item)
		user_rating = investment.value
	end

end

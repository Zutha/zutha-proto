module InvestmentHelper
	def user_rating(item)
		investment = item.investment_of current_user
		user_rating = investment ? investment.value : 0.0
		pretty_round(user_rating)
	end

end

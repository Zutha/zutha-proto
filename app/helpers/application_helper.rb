module ApplicationHelper
	def pretty_round(value)
		value < 0.5 ? value.round(2) : value.round(1)
	end

	def title(page_title)
	  content_for(:title) { page_title }
	end
end

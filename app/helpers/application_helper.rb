module ApplicationHelper
	def title(page_title)
	  content_for(:title) { page_title }
	end

	def pretty_round(value)
		value = case
		when value < 0.5
			value.round(2)
		else
			value.round(1)
		end
		(value % 1.0 == 0.0) ? value.round(0) : value
	end

	def simple_url(url)
		url.sub(%r{https?://}, "")
	end

	def remove_key(hash, key)
		hash1 = hash.clone
		hash1.delete(key)
		hash1
	end
	def update_key(hash, key, value)
		hash1 = hash.clone
		hash1[key] = value
		hash1
	end
end

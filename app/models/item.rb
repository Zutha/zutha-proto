class Item < ActiveRecord::Base
	has_many :investments, :dependent => :destroy

	attr_accessible :name, :description, :url, :worth

	validates :name, :presence => true
	validates_each :worth, :pos_market_height do |record, attr, value|
		if value < 0
			record.errors.add(attr, attr + " cannot be negative")
		end
	end
	validates :url, :url => {:allow_nil => true}

	before_validation :format_params

	scope :by_worth, order('worth DESC')

	def investment_of(user)
		self.investments.where(:user_id => user.try(:id)).first
	end

	protected

	def format_params
		# url
		url = self.url
		self.url = case url
			when "", nil then nil
			when %r"^https?://" then url
			else "http://" + url
		end
	end
end

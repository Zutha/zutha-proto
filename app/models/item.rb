class Item < ActiveRecord::Base
	has_many :investments, :dependent => :destroy
	has_many :tag_links, :dependent => :destroy
	has_many :tags, :through => :tag_links

	# attr_accessible :name, :tags, :url, :description, :worth
	accepts_nested_attributes_for :tag_links, :allow_destroy => true,
    :reject_if => proc { |attrs| attrs['tag_id'].blank? }

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

	def tag_list
		self.tags.map(&:name).join(", ")
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

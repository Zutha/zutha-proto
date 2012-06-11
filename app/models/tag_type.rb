class TagType < ActiveRecord::Base
	has_many :tags
	
	validates :name, :uniqueness=> :true, :presence => true
	validates :url_name, :uniqueness=> :true, :presence => true
end

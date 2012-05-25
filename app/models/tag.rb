class Tag < ActiveRecord::Base
	has_many :tag_links, :dependent => :destroy
	has_many :items, :through => :tag_links

	validates :name, :uniqueness=> :true
end

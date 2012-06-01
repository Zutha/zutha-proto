class Tag < ActiveRecord::Base
	has_many :tag_links, :class_name => "TagLink", :foreign_key => "tag_id", :dependent => :destroy
	has_many :items, :through => :tag_links

	validates :name, :uniqueness=> :true

	scope :categories, where(:is_category => true)
	scope :alphabetically, order(:name)
end

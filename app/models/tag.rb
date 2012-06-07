class Tag < ActiveRecord::Base
	belongs_to :tag_type
	has_many :tag_links, :class_name => "TagLink", :foreign_key => "tag_id", :dependent => :destroy
	has_many :items, :through => :tag_links

	validates :name, :uniqueness=> :true

	scope :item_types, where(:tag_type_id => TagType.where(:name => "Item Type").first)
	scope :alphabetically, order(:name)
end

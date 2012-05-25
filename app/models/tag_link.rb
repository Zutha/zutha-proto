class TagLink < ActiveRecord::Base
  belongs_to :tag
  belongs_to :item

  validates :tag_id, :presence => :true
  validates :item_id, :presence => :true
end

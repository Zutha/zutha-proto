class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	#  :database_authenticatable, :registerable, :validatable, :recoverable, :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
	devise :omniauthable, :rpx_connectable, :rememberable, :trackable

	# Setup accessible (or protected) attributes for your model
	attr_accessible :identifier, :email, :name, :reputation, :zuth

	has_many :investments, :dependent => :destroy

	validates_each :zuth do |record, attr, value|
		if value < 0
			record.errors.add(attr, "user's zuth balance cannot be negative")
		end
	end

	def spend(amount)
		self.zuth -= amount
		self.save!
		#todo: validate +ve
	end

	def receive(amount)
		self.zuth += amount
		self.save!
	end

	# --- Omniauth signin ---
	def self.find_for_open_id(access_token, signed_in_resource=nil)
	  data = access_token.info
	  id = access_token.uid
	  
	  # logger.debug access_token.to_yaml

	  if user = User.find_by_identifier(id)
	    user
	  else
	    User.create!(:identifier => id, :email => data.email, :name => data.name)
	  end
	end
	
	def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
	  data = access_token.info
	  fbdata = access_token.extra.raw_info
	  id = "http://www.facebook.com/profile.php?id=%s" % access_token.uid

	  # logger.debug access_token.to_yaml

	  if user = User.find_by_identifier(id)
	    user
	  else
	    User.create!(:identifier => id, :email => data.email, :name => data.name)
	  end
	end

	# RPX/Engage
	def before_rpx_auto_create(rpx_user)
		logger.debug "\n before_rpx_auto_create():"
		logger.debug rpx_user.to_yaml
		logger.debug self.to_yaml
		
    # self.name = rpx_user.displayName
  end
end

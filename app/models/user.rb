class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	#  :database_authenticatable, :registerable, :validatable, :recoverable, :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable
	devise :omniauthable, :rememberable, :trackable

	# Setup accessible (or protected) attributes for your model
	attr_accessible :identifier, :email, :name, :reputation, :zuth, :admin

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
	def self.find_for_omniauth(access_token, id_prefix)
	  data = access_token.info
	  id = id_prefix + access_token.uid
	  
	  logger.debug access_token.to_yaml

	  if user = User.find_by_identifier(id)
	    user
	  else
	    User.create!(:identifier => id, :email => data.email, :name => data.name)
	  end
	end
	def self.find_for_open_id(access_token)
	  find_for_omniauth(access_token,"")
	end
	def self.find_for_google_oauth(access_token)
		prefix = "https://www.google.com/profiles/"
	  find_for_omniauth(access_token,prefix)
	end
	def self.find_for_facebook_oauth(access_token)
	  fbdata = access_token.extra.raw_info
	  prefix = "http://www.facebook.com/profile.php?id="
		find_for_omniauth(access_token, prefix)
	end
	def self.find_for_windowslive_oauth(access_token)
		prefix = ""
	  find_for_omniauth(access_token,prefix)
	end

end

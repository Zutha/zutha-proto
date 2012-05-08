class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, :rpx_connectable,
	     :recoverable, :rememberable, :trackable, :validatable

	# Setup accessible (or protected) attributes for your model
	attr_accessible :reputation, :zuth, :email, :password, :password_confirmation, :remember_me

	has_many :investments

	def spend(amount)
		self.zuth -= amount
		self.save!
		#todo: validate +ve
	end

	def receive(amount)
		self.zuth += amount
		self.save!
	end
end

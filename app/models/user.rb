class User < ActiveRecord::Base
	has_secure_password validations: false # This is the key to the solution
  	validates :email, uniqueness: true
end

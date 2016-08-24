class User < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	has_secure_password # Fores the user to type the password again to validate it.
end
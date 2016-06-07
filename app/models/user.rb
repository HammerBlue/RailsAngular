class User < ActiveRecord::Base
	include Filterable

	self.table_name = 'user'
	self.primary_key = "ID"	
	has_one :individual, primary_key: 'Individual_Contact_ID', foreign_key: 'Contact_ID'

	# These scopes allow you to filter users, more scopes allow for different filtering options
	scope :LoginName, -> (name) { where("LoginName like ?", "%#{name}%")}

end
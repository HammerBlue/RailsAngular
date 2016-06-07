class Individual < ActiveRecord::Base
	self.table_name = 'individual'
	self.primary_key = "Contact_ID"
	belongs_to :user, foreign_key: 'Contact_ID'
end
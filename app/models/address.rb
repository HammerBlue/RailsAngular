class Address < ActiveRecord::Base
	self.table_name = 'address'
	self.primary_key = "ID"	

	belongs_to :contact, foreign_key: 'Contact_ID'
	belongs_to :state, foreign_key: 'State_ID'
end
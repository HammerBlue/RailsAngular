class Questiontag < ActiveRecord::Base
	self.table_name = 'questiontag'
	self.primary_key = "ID"	

	# belongs_to :partnership, primary_key: 'ID', foreign_key: 'Partnership_ID'
	belongs_to :user, primary_key: 'ID', foreign_key: 'CreatedByUser_ID'
	# belongs to many :question via questiontagmap
end
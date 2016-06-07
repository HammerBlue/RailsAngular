class Questionresource < ActiveRecord::Base
	self.table_name = 'questionresource'
	self.primary_key = "ID"	

	belongs_to :questionversion, primary_key: 'ID', foreign_key: 'QuestionVersion_ID'
	# has many questions/questionversions when type = child foreign_key: 'Text'
	
end
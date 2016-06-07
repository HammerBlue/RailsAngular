class Questionversion < ActiveRecord::Base
	self.table_name = 'questionversion'
	self.primary_key = "ID"	

	belongs_to :assessmentquestion, foreign_key: 'Question_ID'
end
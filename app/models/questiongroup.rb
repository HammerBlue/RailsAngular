class Questiongroup < ActiveRecord::Base
	self.table_name = 'questiongroup'
	self.primary_key = "ID"	

	# has_many :assessmentquestions, primary_key: 'ID', foreign_key: 'QuestionType_ID'
end
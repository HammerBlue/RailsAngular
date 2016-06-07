class Questiontype < ActiveRecord::Base
	self.table_name = 'questiontype'
	self.primary_key = "ID"	

	has_many :assessmentquestions, primary_key: 'ID', foreign_key: 'QuestionType_ID'
end
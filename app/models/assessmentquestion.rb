class Assessmentquestion < ActiveRecord::Base
	self.table_name = 'assessmentquestion'
	self.primary_key = "ID"	

	belongs_to :questiontype, foreign_key: 'QuestionType_ID'
	has_many :questionversions, primary_key: 'ID', foreign_key: 'Question_ID'
	has_one :questionversion, -> { order('questionversion.ID' :desc)}, primary_key: 'ID', foreign_key: 'Question_ID'
end
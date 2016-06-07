class Questiongroupcontents < ActiveRecord::Base
	self.table_name = 'questiongroupcontents'
	self.primary_keys = :Question_ID, :QuestionGroup_ID	

	belongs_to :assessmentquestion, primary_key: 'ID', foreign_key: 'Question_ID'
	belongs_to :questiongroup, primary_key: 'ID', foreign_key: 'QuestionGroup_ID'
end
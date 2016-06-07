class Assessmentcontent < ActiveRecord::Base
	self.table_name = 'assessmentcontents'
	self.primary_keys = :Assessment_ID, :Stage_ID

	belongs_to :assessment, foreign_key: 'Assessment_ID'
	belongs_to :stage, foreign_key: 'Stage_ID'
	
end
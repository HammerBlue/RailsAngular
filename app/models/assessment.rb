class Assessment < ActiveRecord::Base
	self.table_name = 'assessment'
	self.primary_key = "ID"	

#	belongs_to :partnership, foreign_key: 'Partnership_ID'
#	belongs_to :assessment_type, foreign_key: 'AssessmentType_ID'
#	belongs_to :license, foreign_key: 'License_ID'
	has_many :assessmentcontents, primary_key: 'ID', foreign_key: 'Assessment_ID'
	has_many :stages, -> {order('assessmentcontents.SortOrder')}, :through => :assessmentcontents
end

class Stageaccess < ActiveRecord::Base
	self.table_name = 'stageaccess'
	self.primary_key = "ID"

	belongs_to :stage, primary_key: 'ID', foreign_key: 'Stage_ID'
	# belongs_to :assessmentrecord, primary_key: 'ID', foreign_key: 'AssessmentRecord_ID'
	# belongs_to :accessmenttype, primary_key: 'ID', foreign_key: 'AccessType'
end
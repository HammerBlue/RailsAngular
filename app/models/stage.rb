class Stage < ActiveRecord::Base
	self.table_name = 'stage'
	self.primary_key = "ID"	

	has_many :assessmentcontents, primary_key: 'ID', foreign_key: 'Stage_ID'
	has_many :assessments, :through => :assessmentcontents

	has_many :stagecontents, primary_key: 'ID', foreign_key: 'Stage_ID'
	has_many :questiongroups, :through => :stagecontents
	
	
end
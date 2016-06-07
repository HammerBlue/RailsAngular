class StageContents < ActiveRecord::Base
	self.table_name = 'stagecontents'
	self.primary_keys = :Stage_ID, :Group_ID

	belongs_to :stage, primary_key: 'ID', foreign_key: 'Stage_ID'
	belongs_to :questiongroup, primary_key: 'ID', foreign_key: 'Group_ID'
end
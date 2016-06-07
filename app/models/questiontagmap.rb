# may not be needed
class Questiontagmap < ActiveRecord::Base
	self.table_name = 'questiontagmap'
	self.primary_keys = :QuestionVersion_ID, :QuestionTag_ID

	belongs_to :questionversion, primary_key: 'ID', foreign_key: 'QuestionVersion_ID'
	belongs_to :questiontag, primary_key: 'ID', foreign_key: 'QuestionTag_ID'
end
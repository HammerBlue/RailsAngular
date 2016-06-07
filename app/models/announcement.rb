class Announcement < ActiveRecord::Base
	self.table_name = 'announcement'
	self.primary_key = "ID"	


end

__END__

assessmentquestion
	belongs_to questiontype "QuestionType_ID"
	has_many questiontag through questiontagmap
	has_many questionversion
questiongroup
#	belongs_to partnership "Partnership_ID"
	has_many assessmentquestions through questiongroupcontents
questiongroupcontents
	# this is a joiner table
	belongs_to questiongroup "QuestionGroup_ID"
	belongs_to assessmentquestion "Question_ID"
questionresource
	belongs_to questionversion "QuestionVersion_ID"
	has_a questionversion - if type = 'child' foreign_key: 'Text'
questiontag
	belongs_to partnership "Partnership_ID"
	belongs_to user "CreatedByUser_ID"
questiontagmap
	# this is a joiner table
	belongs_to questiontag "QuestionTag_ID"
	belongs_to questionversion "QuestionVersion_ID"
questiontype
	has_many assessmentquestion #we shouldn't ever use this
questionversion
	has_many children through questionresource where type='child'
	belongs_to assessmentquestion "Question_ID"
	has_many questionresources through questionresource



* assessment
	contents
	instance
	programversion
*	question
	record
	type
campaign
	filter
	timeframe
	timeframe_image_clicklog
	timeframe_viewlog
contact
	verification_frequency
	source
country
email
	history
	onstartdate
enrollment
	bundleplacemark
	emailhistory
	fundingsource
	level
	placemark
extension
	history
	notification_image
	notification_timeframe
	promo_message
	purchaselog
externalrequest
failedloginattempt
individual
instance
	answer
	answertext
	group
	stage
	state
	statuslog
license
	version
login_history
object_permissions
organization
	inidividualcontact
panel
partner
partnership
	announcementflag
	academiccalendar
	announcement
	type
phone
program
	# final_exam
	branding
		certificate
		threshold
		addon
		blockset
		bundleoverride
		price
	bundle
	customization
	type
	version
		# accesshistory
		# contents
		# upgrade
promocode
	usage
# question
	# answer
	# content
	# _group
*	group
*		contents
*	resource
*	tag
*	tagmap
*	type
*	version
role
	group_map
	panel
	permisions_map
	type
	report
scoringthreshold
* stage
*	access
*	contents
state
	salestax
statuschangereason
threshold
	collection
		contents
	set
		contents
trainingfield
	certificateflag
	employmentflag
user
	group_map
	# message_group
	# student_message
	group
	# message
	# messageattachment
	partnershiprole
websitecontactinfo


Tables for assessments:

assessmentquestion
questiongroup
questiongroupcontents
questionresource
questiontag
questiontagmap
questiontype
questionversion
stage
stageaccess
stagecontents



# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 1) do

  create_table "activity", primary_key: "ID", force: :cascade do |t|
    t.string "Name",        limit: 64,  null: false
    t.string "Description", limit: 128, null: false
  end

  add_index "activity", ["Name"], name: "UIDX_Activity_Name", unique: true, using: :btree

  create_table "addon", primary_key: "ID", force: :cascade do |t|
    t.string  "Name",        limit: 64,                          null: false
    t.string  "Description", limit: 255
    t.decimal "Price",                   precision: 5, scale: 2, null: false
  end

  add_index "addon", ["Name"], name: "IDX_addon_Name", using: :btree

  create_table "address", primary_key: "ID", force: :cascade do |t|
    t.integer "Contact_ID", limit: 4,  null: false
    t.string  "Purpose",    limit: 8,  null: false
    t.string  "Address1",   limit: 35, null: false
    t.string  "Address2",   limit: 35
    t.string  "City",       limit: 30, null: false
    t.integer "State_ID",   limit: 2,  null: false
    t.string  "PostalCode", limit: 10, null: false
  end

  add_index "address", ["Contact_ID", "Purpose"], name: "UIDX_Address_Contact_ID_Purpose", unique: true, using: :btree
  add_index "address", ["State_ID"], name: "FK_Address_State_ID", using: :btree

  create_table "announcement", primary_key: "ID", force: :cascade do |t|
    t.string   "Title",            limit: 64
    t.text     "AnnouncementText", limit: 65535, null: false
    t.integer  "Author_User_ID",   limit: 4
    t.boolean  "Active",                         null: false
    t.datetime "StartDateTime"
    t.datetime "EndDateTime"
    t.datetime "Modified",                       null: false
  end

  add_index "announcement", ["Author_User_ID"], name: "FK_Announcement_User_ID", using: :btree

  create_table "announcementflag", primary_key: "ID", force: :cascade do |t|
    t.string  "Name",          limit: 128
    t.boolean "SystemDefined"
  end

  add_index "announcementflag", ["Name"], name: "UIDX_AnnouncementFlag_Name", unique: true, using: :btree

  create_table "applicationcontacthistory", primary_key: "ID", force: :cascade do |t|
    t.integer "EmployerApplicationHistory_ID", limit: 4,     null: false
    t.string  "Status",                        limit: 24,    null: false
    t.date    "DateOfLastContact",                           null: false
    t.string  "LastContactMadeBy",             limit: 22
    t.text    "ContactNotes",                  limit: 65535
  end

  add_index "applicationcontacthistory", ["EmployerApplicationHistory_ID"], name: "FK_ApplicationContactHistory_EmployerApplicationHistory_ID", using: :btree

  create_table "assessment", primary_key: "ID", force: :cascade do |t|
    t.integer "Partnership_ID",       limit: 2
    t.string  "Name",                 limit: 64,                    null: false
    t.string  "Description",          limit: 128,                   null: false
    t.integer "AssessmentType_ID",    limit: 1,                     null: false
    t.integer "License_ID",           limit: 1,                     null: false
    t.string  "LogoURL",              limit: 64,                    null: false
    t.integer "DurationMinutes",      limit: 4
    t.integer "Retakes",              limit: 1,                     null: false
    t.boolean "ActiveStatus",                                       null: false
    t.text    "Summary",              limit: 65535
    t.boolean "EnforceDecimal",                     default: true,  null: false
    t.boolean "EnforceQuestionOrder",               default: false, null: false
    t.boolean "ShowHints",                          default: false, null: false
    t.boolean "ShowFeedback",                       default: false, null: false
    t.boolean "ShowInstructions",                   default: false, null: false
    t.boolean "ShowRunningTotal",                   default: false, null: false
    t.integer "QuestionsToDisplay",   limit: 1
    t.boolean "AdminRetakeOverride",                default: false, null: false
  end

  add_index "assessment", ["AssessmentType_ID"], name: "AssessmentType_ID", using: :btree
  add_index "assessment", ["License_ID"], name: "License_ID", using: :btree
  add_index "assessment", ["Name"], name: "AssessmentIdentifier", unique: true, using: :btree
  add_index "assessment", ["Partnership_ID"], name: "Partnership_ID", using: :btree

  create_table "assessmentcontents", id: false, force: :cascade do |t|
    t.integer "Assessment_ID", limit: 4, null: false
    t.integer "SortOrder",     limit: 1, null: false
    t.integer "Stage_ID",      limit: 4, null: false
  end

  add_index "assessmentcontents", ["Assessment_ID", "SortOrder", "Stage_ID"], name: "AssessmentContentsUnique", unique: true, using: :btree
  add_index "assessmentcontents", ["Assessment_ID"], name: "Assessment_ID", using: :btree
#  add_index "assessmentcontents", ["Stage_ID"], name: "OneAssessmentPerStage", unique: true, using: :btree
  add_index "assessmentcontents", ["Stage_ID"], name: "Stage_ID", using: :btree

  create_table "assessmentinstance", primary_key: "ID", force: :cascade do |t|
    t.integer  "Enrollment_ID", limit: 4,                                     null: false
    t.integer  "Attempts",      limit: 1,                         default: 0, null: false
    t.datetime "StartTime"
    t.datetime "EndTime"
    t.decimal  "TotalScore",              precision: 5, scale: 2
  end

  add_index "assessmentinstance", ["Enrollment_ID"], name: "Enrollment_ID", using: :btree

  create_table "assessmentprogramversion", id: false, force: :cascade do |t|
    t.integer "Assessment_ID",     limit: 4, default: 0, null: false
    t.integer "ProgramVersion_ID", limit: 2, default: 0, null: false
  end

  add_index "assessmentprogramversion", ["ProgramVersion_ID"], name: "ProgramVersion_ID", using: :btree

  create_table "assessmentquestion", primary_key: "ID", force: :cascade do |t|
    t.integer  "QuestionType_ID", limit: 1,               null: false
    t.integer  "Discontinued",    limit: 1,   default: 0, null: false
    t.integer  "Status",          limit: 1,               null: false
    t.integer  "CreatedBy",       limit: 4
    t.integer  "UpdatedBy",       limit: 4
    t.datetime "CreatedDate"
    t.datetime "UpdatedDate"
    t.string   "Title",           limit: 128
  end

  add_index "assessmentquestion", ["Discontinued"], name: "AssessmentQuestion_Discontinued", using: :btree
  add_index "assessmentquestion", ["QuestionType_ID"], name: "QuestionType_ID", using: :btree

  create_table "assessmentrecord", primary_key: "ID", force: :cascade do |t|
    t.integer  "User_ID",                 limit: 4, null: false
    t.integer  "Assessment_ID",           limit: 4, null: false
    t.boolean  "CanAccessAssessment",               null: false
    t.date     "SignUpDate"
    t.datetime "FirstLoginDateTime"
    t.datetime "NewestLoginDateTime"
    t.integer  "LoginCount",              limit: 4, null: false
    t.datetime "AcceptedLicenseDateTime"
    t.integer  "LicenseVersion_ID",       limit: 1
  end

  add_index "assessmentrecord", ["Assessment_ID"], name: "Assessment_ID", using: :btree
  add_index "assessmentrecord", ["LicenseVersion_ID"], name: "LicenseVersion_ID", using: :btree
  add_index "assessmentrecord", ["User_ID"], name: "User_ID", using: :btree

  create_table "assessmenttype", primary_key: "ID", force: :cascade do |t|
    t.string "Type",        limit: 32,  null: false
    t.string "Description", limit: 128
  end

  add_index "assessmenttype", ["Type"], name: "AssessmentTypeIdentifier", unique: true, using: :btree

  create_table "block", primary_key: "ID", force: :cascade do |t|
    t.integer "BlockSet_ID", limit: 2, null: false
    t.integer "SortOrder",   limit: 1, null: false
  end

  add_index "block", ["BlockSet_ID", "SortOrder"], name: "UIDX_Block_BlockSet_ID_SortOrder", unique: true, using: :btree

  create_table "blockaccessemail", id: false, force: :cascade do |t|
    t.integer "Enrollment_ID", limit: 4, null: false
    t.date    "EmailDate",               null: false
  end

  create_table "blockaccessstart", id: false, force: :cascade do |t|
    t.integer "Enrollment_ID", limit: 4, null: false
    t.integer "Block_ID",      limit: 2, null: false
    t.date    "StartDate"
  end

  add_index "blockaccessstart", ["Block_ID"], name: "Block_ID", using: :btree

  create_table "blockcontents", id: false, force: :cascade do |t|
    t.integer "Block_ID",  limit: 2, null: false
    t.integer "Module_ID", limit: 2, null: false
  end

  add_index "blockcontents", ["Module_ID"], name: "FK_BlockContents_Module_ID", using: :btree

  create_table "blockmaterial", id: false, force: :cascade do |t|
    t.integer "Block_ID",    limit: 2, null: false
    t.integer "Material_ID", limit: 2, null: false
  end

  add_index "blockmaterial", ["Material_ID"], name: "FK_BlockMaterial_Material_ID", using: :btree

  create_table "blockset", primary_key: "ID", force: :cascade do |t|
    t.integer "ProgramVersion_ID", limit: 2,              null: false
    t.integer "Partnership_ID",    limit: 2
    t.string  "Name",              limit: 64,             null: false
    t.integer "IsVisible",         limit: 1,  default: 1, null: false
  end

  add_index "blockset", ["Name"], name: "UIDX_BlockSet_Name", unique: true, using: :btree
  add_index "blockset", ["Partnership_ID"], name: "FK_BlockSet_Partnership_ID", using: :btree
  add_index "blockset", ["ProgramVersion_ID", "Name"], name: "UIDX_BlockSet_ProgramVersion_ID_Name", unique: true, using: :btree

  create_table "bundleenrollmentstatistic", primary_key: "ID", force: :cascade do |t|
    t.integer  "enrollment_ID",    limit: 4,  default: 0, null: false
    t.datetime "updatedDate",                             null: false
    t.string   "completionStatus", limit: 10
    t.string   "successStatus",    limit: 7
    t.integer  "totalTime",        limit: 4
    t.boolean  "scoreIsKnown"
    t.float    "score",            limit: 53
  end

  add_index "bundleenrollmentstatistic", ["enrollment_ID"], name: "eid", using: :btree

  create_table "campaign", primary_key: "ID", force: :cascade do |t|
    t.string   "Title",       limit: 256
    t.integer  "IsActive",    limit: 1,   default: 1, null: false
    t.integer  "IsOverride",  limit: 1,   default: 0, null: false
    t.datetime "CreatedDate"
    t.datetime "UpdatedDate"
    t.integer  "CreatedBy",   limit: 4
    t.integer  "UpdatedBy",   limit: 4
  end

  create_table "campaign_filter", primary_key: "ID", force: :cascade do |t|
    t.integer "Campaign_ID",  limit: 4
    t.string  "Filter_Value", limit: 32
    t.string  "Filter_Type",  limit: 23
  end

  create_table "campaign_timeframe", primary_key: "ID", force: :cascade do |t|
    t.integer  "Campaign_ID",       limit: 4
    t.integer  "StartOffsetInDays", limit: 2
    t.string   "Behavior",          limit: 8,  default: "Standard",        null: false
    t.integer  "IsActive",          limit: 1,  default: 0,                 null: false
    t.integer  "PromoCode_ID",      limit: 4
    t.date     "EndDate"
    t.date     "StartDate"
    t.string   "Type",              limit: 15, default: "extensionbucket", null: false
    t.integer  "CreatedBy",         limit: 4
    t.integer  "UpdatedBy",         limit: 4
    t.datetime "CreatedDate"
    t.datetime "UpdatedDate"
  end

  add_index "campaign_timeframe", ["Campaign_ID"], name: "FK_Campaign_ID", using: :btree
  add_index "campaign_timeframe", ["PromoCode_ID"], name: "FK_PromoCode_ID", using: :btree

  create_table "campaign_timeframe_image_clicklog", primary_key: "ID", force: :cascade do |t|
    t.integer  "Extension_Notification_Image_ID", limit: 4, null: false
    t.integer  "User_ID",                         limit: 4, null: false
    t.datetime "ClickTime",                                 null: false
  end

  add_index "campaign_timeframe_image_clicklog", ["Extension_Notification_Image_ID"], name: "Extension_Notification_Image_ID", using: :btree
  add_index "campaign_timeframe_image_clicklog", ["User_ID"], name: "User_ID", using: :btree

  create_table "campaign_timeframe_viewlog", primary_key: "ID", force: :cascade do |t|
    t.integer  "Campaign_Timeframe_ID", limit: 4, null: false
    t.integer  "User_ID",               limit: 4, null: false
    t.datetime "ViewTime",                        null: false
  end

  add_index "campaign_timeframe_viewlog", ["Campaign_Timeframe_ID"], name: "Campaign_Timeframe_ID", using: :btree
  add_index "campaign_timeframe_viewlog", ["User_ID"], name: "User_ID", using: :btree

  create_table "candidateemployer", primary_key: "ID", force: :cascade do |t|
    t.string   "Name",             limit: 64,    null: false
    t.text     "HowToContact",     limit: 65535
    t.text     "HowFoundEmployer", limit: 65535
    t.text     "Notes",            limit: 65535
    t.integer  "JobSeeker_ID",     limit: 4,     null: false
    t.integer  "TrainingField_ID", limit: 1,     null: false
    t.datetime "Created",                        null: false
  end

  add_index "candidateemployer", ["JobSeeker_ID"], name: "FK_CandidateEmployer_JobSeeker_ID", using: :btree
  add_index "candidateemployer", ["TrainingField_ID"], name: "FK_CandidateEmployer_TrainingField_ID", using: :btree

  create_table "category", primary_key: "ID", force: :cascade do |t|
    t.string "Name", limit: 32, null: false
  end

  create_table "categorytrainingfield", id: false, force: :cascade do |t|
    t.integer "Category_ID",      limit: 2, null: false
    t.integer "TrainingField_ID", limit: 1, null: false
  end

  add_index "categorytrainingfield", ["TrainingField_ID"], name: "FK_CategoryTrainingField_TrainingField_ID", using: :btree

  create_table "certificate", force: :cascade do |t|
    t.string  "CertName",  limit: 100,                          null: false
    t.string  "ImageName", limit: 100,                          null: false
    t.string  "YName",     limit: 10,                           null: false
    t.string  "YDate",     limit: 10,                           null: false
    t.string  "XName",     limit: 50,                           null: false
    t.string  "XDate",     limit: 50,                           null: false
    t.decimal "CEU_Hours",             precision: 10, scale: 2
    t.string  "Certifier", limit: 100
  end

  add_index "certificate", ["CertName"], name: "CertName", unique: true, using: :btree

  create_table "certificateflag", primary_key: "ID", force: :cascade do |t|
    t.string "Name", limit: 64, null: false
  end

  create_table "changepasswordrequest", id: false, force: :cascade do |t|
    t.integer  "User_ID",  limit: 4,  null: false
    t.string   "Hash",     limit: 64, null: false
    t.datetime "Modified",            null: false
  end

  create_table "class", primary_key: "ID", force: :cascade do |t|
    t.integer "Partnership_ID",     limit: 2,  null: false
    t.integer "ProgramBranding_ID", limit: 2
    t.string  "Name",               limit: 64
    t.date    "StartDate"
    t.date    "EndDate"
  end

  add_index "class", ["Name"], name: "IDX_Class_Name", using: :btree
  add_index "class", ["Partnership_ID", "Name"], name: "UIDX_Class_Partnership_ID_Name", unique: true, using: :btree
  add_index "class", ["ProgramBranding_ID"], name: "IDX_Class_ProgramBranding_ID", using: :btree

  create_table "classannouncement", id: false, force: :cascade do |t|
    t.integer "Announcement_ID", limit: 4, null: false
    t.integer "Class_ID",        limit: 4, null: false
  end

  add_index "classannouncement", ["Class_ID"], name: "FK_ClassAnnouncement_Class_ID", using: :btree

  create_table "classinstructor", id: false, force: :cascade do |t|
    t.integer "Class_ID", limit: 4, null: false
    t.integer "User_ID",  limit: 4, null: false
  end

  add_index "classinstructor", ["User_ID"], name: "IDX_Instructor_User_ID", using: :btree

  create_table "classstudent", id: false, force: :cascade do |t|
    t.integer "Class_ID",      limit: 4, null: false
    t.integer "Enrollment_ID", limit: 4, null: false
  end

  add_index "classstudent", ["Enrollment_ID"], name: "IDX_ClassStudent_Enrollment_ID", using: :btree

  create_table "companionprogram", id: false, force: :cascade do |t|
    t.integer "Program_ID",          limit: 2, null: false
    t.integer "CompanionProgram_ID", limit: 2, null: false
  end

  add_index "companionprogram", ["CompanionProgram_ID"], name: "FK_CompanionProgram_CompanionProgram_ID", using: :btree

  create_table "contact", primary_key: "ID", force: :cascade do |t|
  end

  create_table "contact_verification_frequency", primary_key: "Contact_Verification_Frequency_ID", force: :cascade do |t|
    t.integer "Days_Before_End_Of_Program",   limit: 4, default: 14, null: false
    t.integer "Days_Since_Last_Verification", limit: 4, default: 90, null: false
    t.integer "Minimum_Interval",             limit: 4, default: 30, null: false
    t.integer "Is_Default",                   limit: 1, default: 0,  null: false
  end

  create_table "contactsource", primary_key: "ID", force: :cascade do |t|
    t.string "Name", limit: 64, null: false
  end

  add_index "contactsource", ["Name"], name: "UIDX_ContactSource_Name", unique: true, using: :btree

  create_table "copyrightwatermarkgroup", primary_key: "ID", force: :cascade do |t|
    t.string "Name",         limit: 64,  null: false
    t.string "Copyright",    limit: 128
    t.string "WatermarkURL", limit: 64
  end

  add_index "copyrightwatermarkgroup", ["Name"], name: "UIDX_CopyrightWatermarkGroup_Name", unique: true, using: :btree

  create_table "country", primary_key: "ID", force: :cascade do |t|
    t.string  "Name",            limit: 64, null: false
    t.string  "Alpha2",          limit: 2,  null: false
    t.string  "SubdivisionName", limit: 32, null: false
    t.string  "PhoneFormat",     limit: 32, null: false
    t.string  "PhoneRegex",      limit: 32, null: false
    t.string  "ToDialFromUS",    limit: 64, null: false
    t.string  "PostalCodeRegex", limit: 32, null: false
    t.boolean "WeMailTo",                   null: false
    t.string  "ISO3166-1",       limit: 3
  end

  create_table "email", primary_key: "ID", force: :cascade do |t|
    t.integer "Contact_ID",   limit: 4,  null: false
    t.string  "PrimaryEmail", limit: 9,  null: false
    t.string  "Address",      limit: 64, null: false
  end

  add_index "email", ["Contact_ID", "PrimaryEmail"], name: "UIDX_Phone_Contact_ID_PrimaryEmail", unique: true, using: :btree

  create_table "emailhistory", primary_key: "ID", force: :cascade do |t|
    t.integer  "UserMessage_ID", limit: 4,     null: false
    t.datetime "DateTimeSent",                 null: false
    t.integer  "SentByUser_ID",  limit: 4,     null: false
    t.integer  "Employer_ID",    limit: 2
    t.text     "Notes",          limit: 65535
  end

  add_index "emailhistory", ["Employer_ID"], name: "FK_EmailHistory_Employer_ID", using: :btree
  add_index "emailhistory", ["SentByUser_ID"], name: "FK_EmailHistory_SentByUser_ID", using: :btree
  add_index "emailhistory", ["UserMessage_ID"], name: "FK_EmailHistory_UserMessage_ID", using: :btree

  create_table "emailonstartdate", primary_key: "Enrollment_ID", force: :cascade do |t|
  end

  create_table "employer", primary_key: "ID", force: :cascade do |t|
    t.date    "EndDate"
    t.integer "Partnership_ID",         limit: 2,     null: false
    t.integer "TrainingField_ID",       limit: 1,     null: false
    t.string  "MeansOfApplying",        limit: 7,     null: false
    t.string  "WebsiteOrEmail",         limit: 255,   null: false
    t.text    "HowToApply",             limit: 65535, null: false
    t.text    "CompanyComments",        limit: 65535, null: false
    t.text    "Scheduling",             limit: 65535, null: false
    t.text    "HiringArea",             limit: 65535, null: false
    t.text    "EquipmentProvided",      limit: 65535, null: false
    t.text    "EquipmentRequired",      limit: 65535, null: false
    t.text    "USStatusRequired",       limit: 65535, null: false
    t.text    "CareerStepComments",     limit: 65535
    t.integer "ReferredByJobSeeker_ID", limit: 4
    t.text    "InternalNotes",          limit: 65535
  end

  add_index "employer", ["Partnership_ID", "TrainingField_ID"], name: "UIDX_Employer_Partnership_ID_TrainingField_ID", unique: true, using: :btree
  add_index "employer", ["ReferredByJobSeeker_ID"], name: "FK_Employer_ReferredByJobSeeker_ID", using: :btree
  add_index "employer", ["TrainingField_ID"], name: "FK_Employer_TrainingField_ID", using: :btree

  create_table "employerapplicationhistory", primary_key: "ID", force: :cascade do |t|
    t.integer "Employer_ID",       limit: 2
    t.string  "OtherEmployer",     limit: 64
    t.integer "JobSeeker_ID",      limit: 4,     null: false
    t.date    "DateApplied",                     null: false
    t.date    "DateTestCompleted"
    t.string  "Status",            limit: 24,    null: false
    t.date    "DateOfLastContact",               null: false
    t.string  "LastContactMadeBy", limit: 22
    t.text    "ContactNotes",      limit: 65535
  end

  add_index "employerapplicationhistory", ["Employer_ID"], name: "FK_EmployerApplicationHistory_Employer_ID", using: :btree
  add_index "employerapplicationhistory", ["JobSeeker_ID"], name: "FK_EmployerApplicationHistory_JobSeeker_ID", using: :btree

  create_table "employercertificateflag", id: false, force: :cascade do |t|
    t.integer "Employer_ID",        limit: 2, null: false
    t.integer "CertificateFlag_ID", limit: 1, null: false
    t.boolean "IsWanted",                     null: false
  end

  add_index "employercertificateflag", ["CertificateFlag_ID"], name: "FK_EmployerCertificateFlag_CertificateFlag_ID", using: :btree

  create_table "employeremploymentflag", id: false, force: :cascade do |t|
    t.integer "Employer_ID",       limit: 2, null: false
    t.integer "EmploymentFlag_ID", limit: 1, null: false
    t.boolean "IsOffered",                   null: false
  end

  add_index "employeremploymentflag", ["EmploymentFlag_ID"], name: "FK_EmployerEmploymentFlag_EmploymentFlag_ID", using: :btree

  create_table "employerparticipationhistory", id: false, force: :cascade do |t|
    t.integer  "Employer_ID", limit: 2, null: false
    t.datetime "Modified",              null: false
    t.string   "NewStatus",   limit: 3, null: false
  end

  create_table "employmentflag", primary_key: "ID", force: :cascade do |t|
    t.integer "EmploymentFlagGroup_ID", limit: 1,   null: false
    t.string  "JobSeekerStatement",     limit: 128, null: false
    t.string  "EmployerStatement",      limit: 128, null: false
  end

  add_index "employmentflag", ["EmploymentFlagGroup_ID"], name: "FK_EmploymentFlag_EmploymentFlagGroup_ID", using: :btree

  create_table "employmentflaggroup", primary_key: "ID", force: :cascade do |t|
    t.string "Name", limit: 64, null: false
  end

  add_index "employmentflaggroup", ["Name"], name: "UIDX_EmploymentFlagGroup_Name", unique: true, using: :btree

  create_table "enrollment", primary_key: "ID", force: :cascade do |t|
    t.integer  "User_ID",                    limit: 4,                       null: false
    t.integer  "ProgramBranding_ID",         limit: 2,                       null: false
    t.integer  "ProgramVersion_ID",          limit: 2,                       null: false
    t.integer  "ThresholdCollection_ID",     limit: 2,                       null: false
    t.boolean  "CanAccessProgram",                                           null: false
    t.date     "StartDate"
    t.date     "InitialStartDate"
    t.date     "EndDate",                                                    null: false
    t.integer  "ThemeInfo_ID",               limit: 2,                       null: false
    t.datetime "FirstLoginDateTime"
    t.datetime "NewestLoginDateTime"
    t.integer  "LoginCount",                 limit: 4,                       null: false
    t.integer  "StatusChangeReason_ID",      limit: 1,                       null: false
    t.datetime "Modified",                                                   null: false
    t.integer  "ModifiedBy_User_ID",         limit: 4,                       null: false
    t.integer  "BlockSet_ID",                limit: 2,                       null: false
    t.datetime "AcceptedLicenseDateTime"
    t.integer  "LicenseVersion_ID",          limit: 1
    t.boolean  "MessageSent",                            default: false,     null: false
    t.string   "SalesforceEnrollmentGuid",   limit: 32
    t.integer  "Funding_Source_ID",          limit: 8
    t.integer  "CanCreateFinalExam",         limit: 1,   default: 1,         null: false
    t.integer  "inBundle",                   limit: 4,   default: 0,         null: false
    t.integer  "secondsSpent",               limit: 4
    t.datetime "completedDateTime"
    t.string   "recentModule",               limit: 256
    t.string   "completionStatus",           limit: 10
    t.string   "successStatus",              limit: 7
    t.float    "score",                      limit: 53
    t.boolean  "scoreIsKnown"
    t.string   "EnrollmentType",             limit: 32,  default: "Program", null: false
    t.integer  "EnrollmentFundingSource_ID", limit: 4
    t.date     "completedupdateprocessdate"
  end

  add_index "enrollment", ["BlockSet_ID"], name: "FK_Enrollment_BlockSet_ID", using: :btree
  add_index "enrollment", ["EnrollmentFundingSource_ID"], name: "FK_EnrollmentFundingSource_ID", using: :btree
  add_index "enrollment", ["Funding_Source_ID"], name: "FK_Enrollment_Funding_Source_ID", using: :btree
  add_index "enrollment", ["LicenseVersion_ID"], name: "FK_Enrollment_LicenseVersion_ID", using: :btree
  add_index "enrollment", ["ModifiedBy_User_ID"], name: "FK_Enrollment_ModifiedBy_User_ID", using: :btree
  add_index "enrollment", ["ProgramBranding_ID"], name: "FK_Enrollment_ProgramBranding_ID", using: :btree
  add_index "enrollment", ["ProgramVersion_ID"], name: "FK_Enrollment_ProgramVersion_ID", using: :btree
  add_index "enrollment", ["SalesforceEnrollmentGuid"], name: "IDX_Enrollment_SalesforceEnrollmentGuid", using: :btree
  add_index "enrollment", ["StatusChangeReason_ID"], name: "FK_Enrollment_StatusChangeReason_ID", using: :btree
  add_index "enrollment", ["ThemeInfo_ID"], name: "FK_Enrollment_ThemeInfo_ID", using: :btree
  add_index "enrollment", ["ThresholdCollection_ID"], name: "FK_Enrollment_ThresholdCollection_ID", using: :btree
  add_index "enrollment", ["User_ID"], name: "FK_Enrollment_User_ID", using: :btree

  create_table "enrollmentbundleplacemark", primary_key: "Enrollment_ID", force: :cascade do |t|
    t.integer "childVersion_ID", limit: 4
  end

  create_table "enrollmentemailhistory", id: false, force: :cascade do |t|
    t.integer "EmailHistory_ID", limit: 4, null: false
    t.integer "Enrollment_ID",   limit: 4, null: false
  end

  add_index "enrollmentemailhistory", ["Enrollment_ID"], name: "FK_EnrollmentEmailRecipientHistory_Enrollment_ID", using: :btree

  create_table "enrollmentfundingsource", primary_key: "ID", force: :cascade do |t|
    t.string "Name", limit: 128
  end

  add_index "enrollmentfundingsource", ["Name"], name: "Name", unique: true, using: :btree

  create_table "enrollmentlevel", primary_key: "ID", force: :cascade do |t|
    t.integer "Enrollment_ID", limit: 4, null: false
    t.string  "Level",         limit: 8, null: false
  end

  add_index "enrollmentlevel", ["Enrollment_ID"], name: "FK_EnrollmentLevel_Enrollment", using: :btree

  create_table "enrollmentplacemark", primary_key: "Enrollment_ID", force: :cascade do |t|
    t.integer "ModuleVersion_ID", limit: 2, null: false
    t.integer "PageOffset",       limit: 2, null: false
  end

  add_index "enrollmentplacemark", ["ModuleVersion_ID"], name: "FK_EnrollmentPlacemark_ModuleVersion_ID", using: :btree

  create_table "eventaction", primary_key: "ID", force: :cascade do |t|
    t.string "Type",        limit: 64,  null: false
    t.string "Description", limit: 256
  end

  add_index "eventaction", ["ID"], name: "ID", using: :btree
  add_index "eventaction", ["Type"], name: "EventActionIdentifier", unique: true, using: :btree

  create_table "events", primary_key: "ID", force: :cascade do |t|
    t.integer "EventType_ID",        limit: 2, null: false
    t.integer "EventStage_ID",       limit: 4, null: false
    t.integer "EventAction_ID",      limit: 2, null: false
    t.integer "EventActionStage_ID", limit: 4, null: false
    t.integer "Assessment_ID",       limit: 4, null: false
  end

  add_index "events", ["Assessment_ID"], name: "Assessment_ID", using: :btree
  add_index "events", ["EventActionStage_ID"], name: "EventActionStage_ID", using: :btree
  add_index "events", ["EventAction_ID"], name: "EventAction_ID", using: :btree
  add_index "events", ["EventStage_ID"], name: "EventStage_ID", using: :btree
  add_index "events", ["EventType_ID", "EventStage_ID", "EventAction_ID", "EventActionStage_ID", "Assessment_ID"], name: "EventsIdentifier", unique: true, using: :btree
  add_index "events", ["EventType_ID"], name: "EventType_ID", using: :btree

  create_table "eventtype", primary_key: "ID", force: :cascade do |t|
    t.string "Type",        limit: 64,  null: false
    t.string "Description", limit: 256
  end

  add_index "eventtype", ["ID"], name: "ID", using: :btree
  add_index "eventtype", ["Type"], name: "EventTypeIdentifier", unique: true, using: :btree

  create_table "exam", primary_key: "Exam_ID", force: :cascade do |t|
    t.integer  "Enrollment_ID",  limit: 4,             null: false
    t.integer  "Score",          limit: 2
    t.datetime "Start_DT",                             null: false
    t.datetime "Complete_DT"
    t.integer  "Grader_User_ID", limit: 4
    t.datetime "Graded_DT"
    t.integer  "Passed",         limit: 1, default: 1, null: false
  end

  add_index "exam", ["Enrollment_ID"], name: "FK_Exam_Enrollment_Enrollment_ID", using: :btree
  add_index "exam", ["Grader_User_ID"], name: "FK_Exam_User_Grader_User_ID", using: :btree

  create_table "exam_question", id: false, force: :cascade do |t|
    t.integer "Exam_ID",           limit: 8,        null: false
    t.integer "Question_ID",       limit: 8,        null: false
    t.integer "Question_Group_ID", limit: 8,        null: false
    t.integer "Layout_Order",      limit: 2,        null: false
    t.text    "Response",          limit: 16777215
    t.integer "Score",             limit: 8
    t.text    "Comments",          limit: 16777215
    t.string  "Points",            limit: 10
  end

  add_index "exam_question", ["Question_Group_ID"], name: "FK_ExamQuestion_QuestionGroup_Question_Group_ID", using: :btree
  add_index "exam_question", ["Question_ID"], name: "FK_ExamQuestion_Question_Question_ID", using: :btree

  create_table "exam_question_group", id: false, force: :cascade do |t|
    t.integer  "Exam_ID",           limit: 8, null: false
    t.integer  "Question_Group_ID", limit: 8, null: false
    t.integer  "Group_Score",       limit: 2, null: false
    t.datetime "Save_DT",                     null: false
  end

  add_index "exam_question_group", ["Question_Group_ID"], name: "FK_ExamQuestionGroup_QuestionGroup_Question_Group_ID", using: :btree

  create_table "extension", primary_key: "ID", force: :cascade do |t|
    t.integer  "ProgramVersion_ID",       limit: 2,                                      null: false
    t.decimal  "Price",                             precision: 5,  scale: 2,             null: false
    t.integer  "NumberOfMonths",          limit: 1,                                      null: false
    t.integer  "NumberOfPayments",        limit: 1,                          default: 1
    t.integer  "EndDateStartOffset",      limit: 1,                                      null: false
    t.integer  "EndDateEndOffset",        limit: 1,                                      null: false
    t.decimal  "Late_Fee",                          precision: 10, scale: 2
    t.decimal  "reactivation90",                    precision: 10, scale: 2
    t.decimal  "reactivation180",                   precision: 10, scale: 2
    t.decimal  "Discount",                          precision: 10, scale: 2
    t.decimal  "Secondary_Discount",                precision: 10, scale: 2
    t.integer  "Number_Of_Extensions",    limit: 4
    t.decimal  "FinanceCharge",                     precision: 10, scale: 2
    t.boolean  "MonthlyPaymentAvailable",                                                null: false
    t.integer  "CreatedBy",               limit: 4
    t.integer  "UpdatedBy",               limit: 4
    t.datetime "CreatedDate"
    t.datetime "UpdatedDate"
  end

  add_index "extension", ["ProgramVersion_ID"], name: "FK_Extension_ProgramVersion_ID", using: :btree

  create_table "extension_history", force: :cascade do |t|
    t.string   "given_names",             limit: 100
    t.string   "last_name",               limit: 100
    t.decimal  "amount",                              precision: 10, scale: 2
    t.integer  "quantity",                limit: 4
    t.integer  "late_months",             limit: 4
    t.integer  "late_days",               limit: 4
    t.string   "account_guid",            limit: 100
    t.string   "enrollment_guid",         limit: 100
    t.integer  "number_of_months",        limit: 4
    t.string   "auth_code",               limit: 20
    t.datetime "old_end_date"
    t.string   "invoice_number",          limit: 30
    t.datetime "new_end_date"
    t.string   "cc_xxx_num",              limit: 100
    t.integer  "expiration_month",        limit: 1
    t.integer  "expiration_year",         limit: 2
    t.string   "transaction_id",          limit: 100
    t.string   "funding_source",          limit: 30
    t.decimal  "finance_charge",                      precision: 10, scale: 2
    t.integer  "finance_charge_quantity", limit: 1
    t.string   "finance_charge_guid",     limit: 100
    t.string   "rejection_reason",        limit: 255
  end

  create_table "extension_notification_image", primary_key: "ID", force: :cascade do |t|
    t.integer  "Campaign_TimeFrame_ID", limit: 4
    t.string   "Type",                  limit: 6
    t.boolean  "NewWindow",                              default: false
    t.boolean  "Active",                                 default: false
    t.binary   "Image",                 limit: 16777215
    t.integer  "CreatedBy",             limit: 4
    t.integer  "UpdatedBy",             limit: 4
    t.datetime "CreatedDate"
    t.datetime "UpdatedDate"
    t.text     "NavigateURL",           limit: 65535
  end

  add_index "extension_notification_image", ["Campaign_TimeFrame_ID"], name: "FK_CampaignTimeFrame", using: :btree

  create_table "extension_notification_timeframe", primary_key: "ID", force: :cascade do |t|
    t.string  "Title",             limit: 255, null: false
    t.integer "StartOffsetInDays", limit: 2
    t.string  "Behavior",          limit: 8,   null: false
  end

  add_index "extension_notification_timeframe", ["StartOffsetInDays"], name: "StartOffsetInDays", unique: true, using: :btree

  create_table "extension_promo_message", primary_key: "ID", force: :cascade do |t|
    t.text    "Message",                             limit: 65535, null: false
    t.integer "Extension_Notification_Timeframe_ID", limit: 4,     null: false
    t.integer "Extension_ID",                        limit: 4,     null: false
  end

  add_index "extension_promo_message", ["Extension_ID"], name: "Extension_ID", using: :btree
  add_index "extension_promo_message", ["Extension_Notification_Timeframe_ID"], name: "Extension_Notification_Timeframe_ID", using: :btree

  create_table "extensionpurchaselog", primary_key: "InvoiceNumber", force: :cascade do |t|
    t.integer  "Enrollment_ID",  limit: 4,   null: false
    t.string   "ResponseString", limit: 511, null: false
    t.datetime "LogDateTime",                null: false
  end

  add_index "extensionpurchaselog", ["Enrollment_ID"], name: "FK_ExtensionPurchaseLog_Enrollment", using: :btree

  create_table "externalrequest", primary_key: "ID", force: :cascade do |t|
    t.datetime "requestDate",                    null: false
    t.string   "requestType",       limit: 6
    t.string   "url",               limit: 1024
    t.string   "requestParameters", limit: 1024
    t.string   "contentType",       limit: 128
    t.integer  "responseCode",      limit: 4
    t.integer  "totalResponseTime", limit: 4
  end

  create_table "failedloginattempt", primary_key: "ID", force: :cascade do |t|
    t.datetime "Created",                     null: false
    t.string   "LoginName",        limit: 64
    t.string   "Password",         limit: 64
    t.string   "ReasonForFailure", limit: 16
    t.boolean  "ReadyForDeletion",            null: false
    t.boolean  "Suspicious",                  null: false
  end

  add_index "failedloginattempt", ["LoginName"], name: "IDX_FailedLoginAttempt_LoginName", using: :btree

  create_table "faq", primary_key: "FAQ_ID", force: :cascade do |t|
    t.integer "Title_From_Module", limit: 1,     default: 1, null: false
    t.text    "Question",          limit: 65535,             null: false
    t.text    "Answer",            limit: 65535,             null: false
    t.integer "FAQ_Header_ID",     limit: 8
    t.integer "ProgramVersion_ID", limit: 2,                 null: false
    t.integer "Module_ID",         limit: 2
  end

  add_index "faq", ["FAQ_Header_ID"], name: "FK_FAQ_FAQ_Header_ID", using: :btree
  add_index "faq", ["Module_ID"], name: "FK_FAQ_Module_ID", using: :btree
  add_index "faq", ["ProgramVersion_ID"], name: "FK_FAQ_ProgramVersion_ID", using: :btree

  create_table "faq_header", primary_key: "FAQ_Header_ID", force: :cascade do |t|
    t.string "Title", limit: 64, null: false
  end

  create_table "fayettevilleeids", id: false, force: :cascade do |t|
    t.integer "oldEnrollment_ID", limit: 4
    t.integer "newEnrollment_ID", limit: 4
  end

  create_table "funding_source", primary_key: "Funding_Source_ID", force: :cascade do |t|
    t.string  "Name",        limit: 50,                null: false
    t.text    "Description", limit: 65535
    t.integer "Is_Active",   limit: 1,     default: 1, null: false
  end

  add_index "funding_source", ["Name"], name: "UIDX_FundingSource_Name", unique: true, using: :btree

  create_table "gameboard", primary_key: "ID", force: :cascade do |t|
    t.string "Name", limit: 32, null: false
  end

  add_index "gameboard", ["Name"], name: "UIDX_GameBoard_Name", unique: true, using: :btree

  create_table "gameboardscore", id: false, force: :cascade do |t|
    t.integer "User_ID",      limit: 4, null: false
    t.integer "GameBoard_ID", limit: 2, null: false
    t.integer "Attempt",      limit: 4, null: false
    t.integer "Score",        limit: 4, null: false
    t.date    "Created",                null: false
  end

  add_index "gameboardscore", ["Created"], name: "IDX_GameBoardScore_Created", using: :btree
  add_index "gameboardscore", ["GameBoard_ID"], name: "FK_GameBoardScore_GameBoard_ID", using: :btree
  add_index "gameboardscore", ["Score"], name: "IDX_GameBoardScore_Score", using: :btree

  create_table "gamefakename", primary_key: "User_ID", force: :cascade do |t|
    t.string "Name", limit: 30, null: false
  end

  create_table "generalannouncement", primary_key: "Announcement_ID", force: :cascade do |t|
    t.integer "TrainingField_ID", limit: 1
    t.boolean "Reviewed",                   null: false
  end

  add_index "generalannouncement", ["TrainingField_ID"], name: "FK_GeneralAnnouncement_TrainingField_ID", using: :btree

  create_table "generalannouncement_announcementflag", id: false, force: :cascade do |t|
    t.integer "GeneralAnnouncement_ID", limit: 4, null: false
    t.integer "AnnouncementFlag_ID",    limit: 1, null: false
    t.boolean "DoesApply",                        null: false
  end

  add_index "generalannouncement_announcementflag", ["AnnouncementFlag_ID"], name: "FK_GeneralAnnouncement_AnnouncementFlag_AnnouncementFlag_ID", using: :btree

  create_table "gradecolor", primary_key: "ID", force: :cascade do |t|
    t.string "Name", limit: 6, null: false
  end

  add_index "gradecolor", ["Name"], name: "UIDX_GradeColor_Name", unique: true, using: :btree

  create_table "gradegraphic", primary_key: "ID", force: :cascade do |t|
    t.string "Name", limit: 64, null: false
  end

  add_index "gradegraphic", ["Name"], name: "UIDX_GradeGraphic_Name", unique: true, using: :btree

  create_table "gradename", primary_key: "ID", force: :cascade do |t|
    t.string "Name", limit: 64, null: false
  end

  add_index "gradename", ["Name"], name: "UIDX_GradeName_Name", unique: true, using: :btree

  create_table "graduate", primary_key: "Enrollment_ID", force: :cascade do |t|
    t.date    "GraduationDate",                null: false
    t.string  "GraduationLevel",    limit: 11, null: false
    t.integer "ModifiedBy_User_ID", limit: 4,  null: false
  end

  add_index "graduate", ["ModifiedBy_User_ID"], name: "FK_Graduate_ModifiedBy_User_ID", using: :btree

  create_table "howbecameinterested", primary_key: "ID", force: :cascade do |t|
    t.integer "ContactSource_ID",         limit: 1
    t.string  "ContactSourceDescription", limit: 128
    t.integer "ReferrerIndividual_ID",    limit: 4
    t.string  "ReferrerCompanyName",      limit: 64
    t.string  "ReferrerPosition",         limit: 64
    t.integer "TrainingPartnership_ID",   limit: 2
    t.integer "TestingPartnership_ID",    limit: 2
    t.string  "IndustryAssociation",      limit: 20
    t.string  "AffiliateCode",            limit: 32
    t.string  "AdvertisingCode",          limit: 32
    t.string  "ConventionCode",           limit: 32
  end

  add_index "howbecameinterested", ["ContactSource_ID"], name: "FK_HowBecameInterested_ContactSource_ID", using: :btree
  add_index "howbecameinterested", ["ReferrerIndividual_ID"], name: "FK_HowBecameInterested_ReferrerIndividual_ID", using: :btree
  add_index "howbecameinterested", ["TestingPartnership_ID"], name: "FK_HowBecameInterested_TestingPartnership_ID", using: :btree
  add_index "howbecameinterested", ["TrainingPartnership_ID"], name: "FK_HowBecameInterested_TrainingPartnership_ID", using: :btree

  create_table "individual", primary_key: "Contact_ID", force: :cascade do |t|
    t.string  "PreferredName",             limit: 64
    t.string  "GivenNames",                limit: 64,                         null: false
    t.string  "Surname",                   limit: 64,                         null: false
    t.boolean "PreferSurnameFirst",                                           null: false
    t.string  "FileMaker_ID",              limit: 32
    t.string  "PHPTimeZone",               limit: 64
    t.boolean "BillAnotherPerson",                     default: false,        null: false
    t.string  "BillingGivenNames",         limit: 64
    t.string  "BillingSurname",            limit: 64
    t.string  "SalesforceUserAccountGuid", limit: 32
    t.integer "SalesforceStudentID",       limit: 4,   default: 0
    t.date    "Last_Verification_Date",                default: '1970-01-01', null: false
    t.string  "External_ID",               limit: 30
    t.string  "External_Dept",             limit: 100
    t.string  "Title",                     limit: 50
  end

  add_index "individual", ["FileMaker_ID"], name: "UIDX_Individual_FileMaker_ID", unique: true, using: :btree
  add_index "individual", ["SalesforceUserAccountGuid"], name: "IDX_Individual_SalesforceUserAccountGuid", using: :btree

  create_table "informationrequest", primary_key: "ID", force: :cascade do |t|
    t.integer  "Individual_ID",             limit: 4,     null: false
    t.datetime "RequestDateTime",                         null: false
    t.integer  "TrainingField_ID",          limit: 1,     null: false
    t.string   "MeansOfRequest",            limit: 8,     null: false
    t.boolean  "DidRequestWePhone",                       null: false
    t.boolean  "DidRequestWeMail",                        null: false
    t.boolean  "DidRequestWeEmail",                       null: false
    t.boolean  "IsAHealthCareProfessional",               null: false
    t.text     "SpecialInstructions",       limit: 65535
    t.integer  "HowBecameInterested_ID",    limit: 4
  end

  add_index "informationrequest", ["HowBecameInterested_ID"], name: "FK_InformationRequest_HowBecameInterested_ID", using: :btree
  add_index "informationrequest", ["Individual_ID"], name: "FK_InformationRequest_Individual_ID", using: :btree
  add_index "informationrequest", ["TrainingField_ID"], name: "FK_InformationRequest_TrainingField_ID", using: :btree

  create_table "instanceanswer", primary_key: "ID", force: :cascade do |t|
    t.integer "InstanceGroup_ID",    limit: 4, null: false
    t.integer "QuestionResource_ID", limit: 8, null: false
  end

  add_index "instanceanswer", ["InstanceGroup_ID"], name: "InstanceGroup_ID", using: :btree
  add_index "instanceanswer", ["QuestionResource_ID"], name: "QuestionOption_ID", using: :btree

  create_table "instanceanswertext", primary_key: "ID", force: :cascade do |t|
    t.integer "InstanceAnswer_ID", limit: 4,                     null: false
    t.text    "Text",              limit: 65535
    t.integer "IsMarked",          limit: 1,     default: 0,     null: false
    t.integer "PointsTakenOff",    limit: 4
    t.boolean "NoPassIssued",                    default: false
  end

  add_index "instanceanswertext", ["InstanceAnswer_ID"], name: "InstanceAnswer_ID", using: :btree

  create_table "instancegroup", primary_key: "ID", force: :cascade do |t|
    t.integer "InstanceStage_ID",   limit: 4, null: false
    t.integer "QuestionGroup_ID",   limit: 4, null: false
    t.integer "QuestionVersion_ID", limit: 8, null: false
    t.integer "SortOrder",          limit: 4, null: false
  end

  add_index "instancegroup", ["InstanceStage_ID"], name: "InstanceStage_ID", using: :btree
  add_index "instancegroup", ["QuestionGroup_ID"], name: "QuestionGroup_ID", using: :btree
  add_index "instancegroup", ["QuestionVersion_ID"], name: "QuestionVersion_ID", using: :btree
  add_index "instancegroup", ["SortOrder"], name: "InstanceGroup_SortOrder", using: :btree

  create_table "instancestage", primary_key: "ID", force: :cascade do |t|
    t.integer "Instance_ID",    limit: 4,                 null: false
    t.integer "Stage_ID",       limit: 4,                 null: false
    t.integer "Score",          limit: 2
    t.boolean "NoPassIssued",             default: false
    t.integer "LastGroupIndex", limit: 4, default: 0
    t.integer "LastPageIndex",  limit: 4, default: 0
    t.boolean "IsSubmitted",              default: false, null: false
  end

  add_index "instancestage", ["Instance_ID"], name: "Instance_ID", using: :btree
  add_index "instancestage", ["Stage_ID"], name: "Stage_ID", using: :btree

  create_table "instancestate", primary_key: "ID", force: :cascade do |t|
    t.string "State",       limit: 64,  null: false
    t.string "Description", limit: 256
  end

  add_index "instancestate", ["State"], name: "InstanceStateIdentifier", unique: true, using: :btree

  create_table "instancestatuslog", primary_key: "ID", force: :cascade do |t|
    t.integer  "Instance_ID",      limit: 4,                       null: false
    t.integer  "InstanceState_ID", limit: 1,                       null: false
    t.datetime "LogTimeStamp",                                     null: false
    t.integer  "Updater_User_ID",  limit: 4
    t.string   "Type",             limit: 13, default: "Instance", null: false
  end

  add_index "instancestatuslog", ["InstanceState_ID"], name: "InstanceState_ID", using: :btree
  add_index "instancestatuslog", ["Instance_ID"], name: "Instance_ID", using: :btree
  add_index "instancestatuslog", ["Updater_User_ID"], name: "FK_InstanceStatusLog_User_ID", using: :btree

  create_table "internalscormglobalobjective", id: false, force: :cascade do |t|
    t.string  "ID",                    limit: 150, null: false
    t.integer "enrollment_ID",         limit: 4,   null: false
    t.string  "completionStatus",      limit: 7
    t.string  "completionStatusValue", limit: 10
    t.boolean "measureStatus"
    t.integer "objectiveIndex",        limit: 4,   null: false
    t.float   "normalizedMeasure",     limit: 53
    t.float   "progressMeasure",       limit: 53
    t.boolean "progressMeasureStatus"
    t.boolean "progressStatus"
    t.boolean "satisfiedStatus"
    t.float   "scoreMax",              limit: 53
    t.float   "scoreMin",              limit: 53
    t.float   "scoreRaw",              limit: 53
    t.string  "scormRegistrationId",   limit: 150
  end

  create_table "internalscorminteraction", id: false, force: :cascade do |t|
    t.string   "ID",               limit: 150, null: false
    t.integer  "enrollment_ID",    limit: 4,   null: false
    t.datetime "createdDate",                  null: false
    t.integer  "interactionIndex", limit: 4,   null: false
    t.string   "latency",          limit: 30
    t.string   "learnerResponse",  limit: 500
    t.string   "correctResponse",  limit: 512
    t.string   "result",           limit: 500
    t.integer  "activityId",       limit: 4
    t.string   "type",             limit: 30
    t.float    "weighting",        limit: 53
    t.string   "description",      limit: 250
  end

  create_table "internalscormrtobjective", id: false, force: :cascade do |t|
    t.string  "ID",               limit: 150, null: false
    t.integer "enrollment_ID",    limit: 4,   null: false
    t.string  "completionStatus", limit: 10
    t.string  "description",      limit: 500
    t.integer "objectiveIndex",   limit: 4,   null: false
    t.float   "progressMeasure",  limit: 53
    t.float   "scoreMax",         limit: 53
    t.float   "scoreMin",         limit: 53
    t.float   "scoreRaw",         limit: 53
    t.float   "scoreScaled",      limit: 53
    t.integer "activityId",       limit: 4
    t.string  "successStatus",    limit: 7
  end

  create_table "internalscormstatistic", primary_key: "ID", force: :cascade do |t|
    t.datetime "createdDate",                  null: false
    t.datetime "launchTime"
    t.integer  "enrollment_ID",     limit: 4,  null: false
    t.string   "completionStatus",  limit: 10
    t.string   "successStatus",     limit: 7
    t.integer  "totalTime",         limit: 4
    t.integer  "launchTimeElapsed", limit: 4
    t.boolean  "scoreIsKnown"
    t.float    "score",             limit: 53
    t.boolean  "isExitScore"
    t.float    "percentComplete",   limit: 53
    t.string   "mode",              limit: 6
  end

  add_index "internalscormstatistic", ["enrollment_ID"], name: "eid", using: :btree

  create_table "jobseeker", primary_key: "ID", force: :cascade do |t|
    t.integer  "User_ID",                  limit: 4,     null: false
    t.integer  "Tutorial_Enrollment_ID",   limit: 4
    t.integer  "TrainingField_ID",         limit: 1,     null: false
    t.string   "Level",                    limit: 8,     null: false
    t.integer  "Graduate_Enrollment_ID",   limit: 4
    t.boolean  "CanAccessPlacementDirect",               null: false
    t.date     "StartDate",                              null: false
    t.date     "EndDate",                                null: false
    t.datetime "FirstLoginDateTime"
    t.datetime "NewestLoginDateTime"
    t.integer  "LoginCount",               limit: 4,     null: false
    t.integer  "StatusChangeReason_ID",    limit: 1,     null: false
    t.datetime "Modified",                               null: false
    t.integer  "ModifiedBy_User_ID",       limit: 4,     null: false
    t.text     "InternalNotes",            limit: 65535
    t.boolean  "WeCanEmail",                             null: false
  end

  add_index "jobseeker", ["Graduate_Enrollment_ID"], name: "FK_JobSeeker_Graduate_Enrollment_ID", using: :btree
  add_index "jobseeker", ["ModifiedBy_User_ID"], name: "FK_JobSeeker_ModifiedBy_User_ID", using: :btree
  add_index "jobseeker", ["StatusChangeReason_ID"], name: "FK_JobSeeker_StatusChangeReason_ID", using: :btree
  add_index "jobseeker", ["TrainingField_ID"], name: "FK_JobSeeker_TrainingField_ID", using: :btree
  add_index "jobseeker", ["Tutorial_Enrollment_ID"], name: "FK_JobSeeker_Tutorial_Enrollment_ID", using: :btree
  add_index "jobseeker", ["User_ID"], name: "FK_JobSeeker_User_ID", using: :btree

  create_table "jobseekercertificateflag", id: false, force: :cascade do |t|
    t.integer  "JobSeeker_ID",       limit: 4, null: false
    t.integer  "CertificateFlag_ID", limit: 1, null: false
    t.date     "DateTaken",                    null: false
    t.datetime "DateReportedToCS"
    t.string   "Status",             limit: 7, null: false
  end

  add_index "jobseekercertificateflag", ["CertificateFlag_ID"], name: "FK_JobSeekerCertificateFlag_CertificateFlag_ID", using: :btree

  create_table "jobseekeremailhistory", id: false, force: :cascade do |t|
    t.integer "EmailHistory_ID", limit: 4, null: false
    t.integer "JobSeeker_ID",    limit: 4, null: false
  end

  add_index "jobseekeremailhistory", ["JobSeeker_ID"], name: "FK_JobSeekerEmailRecipientHistory_JobSeeker_ID", using: :btree

  create_table "jobseekeremploymentflag", id: false, force: :cascade do |t|
    t.integer "JobSeeker_ID",      limit: 4, null: false
    t.integer "EmploymentFlag_ID", limit: 1, null: false
    t.boolean "IsWanted",                    null: false
  end

  add_index "jobseekeremploymentflag", ["EmploymentFlag_ID"], name: "FK_JobSeekerEmploymentFlag_EmploymentFlag_ID", using: :btree

  create_table "jobseekeremploymenthistory", primary_key: "ID", force: :cascade do |t|
    t.integer "JobSeeker_ID",  limit: 4,  null: false
    t.integer "Employer_ID",   limit: 2
    t.string  "OtherEmployer", limit: 64
    t.date    "StartDate",                null: false
    t.date    "EndDate"
  end

  add_index "jobseekeremploymenthistory", ["Employer_ID"], name: "FK_JobSeekerEmploymentHistory_Employer_ID", using: :btree
  add_index "jobseekeremploymenthistory", ["JobSeeker_ID"], name: "FK_JobSeekerEmploymentHistory_JobSeeker_ID", using: :btree

  create_table "jobseekerspecialty", id: false, force: :cascade do |t|
    t.integer "JobSeekerEmploymentHistory_ID", limit: 4, null: false
    t.integer "Specialty_ID",                  limit: 1, null: false
  end

  add_index "jobseekerspecialty", ["Specialty_ID"], name: "FK_JobSeekerSpecialty_Specialty_ID", using: :btree

  create_table "jobseekerstatushistory", primary_key: "ID", force: :cascade do |t|
    t.integer  "JobSeeker_ID",             limit: 4, null: false
    t.string   "Level",                    limit: 8, null: false
    t.boolean  "CanAccessPlacementDirect",           null: false
    t.date     "StartDate",                          null: false
    t.date     "EndDate",                            null: false
    t.integer  "StatusChangeReason_ID",    limit: 1, null: false
    t.datetime "Modified",                           null: false
    t.integer  "ModifiedBy_User_ID",       limit: 4, null: false
  end

  add_index "jobseekerstatushistory", ["JobSeeker_ID"], name: "FK_JobSeekerStatusHistory_JobSeeker_ID", using: :btree
  add_index "jobseekerstatushistory", ["ModifiedBy_User_ID"], name: "FK_JobSeekerStatusHistory_ModifiedBy_User_ID", using: :btree
  add_index "jobseekerstatushistory", ["StatusChangeReason_ID"], name: "FK_JobSeekerStatusHistory_StatusChangeReason_ID", using: :btree

  create_table "legacytrainingcertificate", force: :cascade do |t|
    t.integer "Enrollment_ID", limit: 4,   null: false
    t.string  "Name",          limit: 255
    t.string  "Program",       limit: 255
    t.string  "Date",          limit: 128
  end

  add_index "legacytrainingcertificate", ["Enrollment_ID"], name: "FK_LegacyTrainingCertificate_Enrollment_ID", using: :btree

  create_table "license", primary_key: "ID", force: :cascade do |t|
    t.string "Name",        limit: 32,  null: false
    t.string "Description", limit: 128, null: false
  end

  add_index "license", ["Name"], name: "UIDX_License_Name", unique: true, using: :btree

  create_table "licenseversion", primary_key: "ID", force: :cascade do |t|
    t.integer  "License_ID",  limit: 1,     null: false
    t.datetime "DateCreated",               null: false
    t.text     "Agreement",   limit: 65535, null: false
  end

  add_index "licenseversion", ["License_ID", "DateCreated"], name: "UIDX_LicenseVersion_License_ID_DateCreated", unique: true, using: :btree

  create_table "login_history", primary_key: "ID", force: :cascade do |t|
    t.integer  "Enrollment_ID",      limit: 4, null: false
    t.integer  "ProgramBranding_ID", limit: 2
    t.datetime "Login"
    t.datetime "PageChange"
    t.datetime "Logout"
  end

  add_index "login_history", ["Enrollment_ID"], name: "Enrollment_ID", using: :btree
  add_index "login_history", ["ProgramBranding_ID"], name: "ProgramBranding_ID", using: :btree

  create_table "marketingcontact", primary_key: "Individual_ID", force: :cascade do |t|
    t.boolean "DidRequestWeNotContact", default: false, null: false
  end

  create_table "material", primary_key: "ID", force: :cascade do |t|
    t.string "Name", limit: 64, null: false
  end

  create_table "materialrequest", id: false, force: :cascade do |t|
    t.integer  "Enrollment_ID", limit: 4,  null: false
    t.integer  "Material_ID",   limit: 2,  null: false
    t.datetime "DateRequested",            null: false
    t.string   "Status",        limit: 13, null: false
  end

  add_index "materialrequest", ["Material_ID"], name: "FK_MaterialRequest_Material_ID", using: :btree

  create_table "message", primary_key: "ID", force: :cascade do |t|
    t.string "Subject", limit: 255,   null: false
    t.text   "Message", limit: 65535, null: false
  end

  create_table "message_group", primary_key: "Message_Group_ID", force: :cascade do |t|
    t.string   "Name",      limit: 500, null: false
    t.datetime "Create_DT",             null: false
    t.integer  "Class_ID",  limit: 4
  end

  add_index "message_group", ["Class_ID"], name: "FK_Class_MessageGroup", using: :btree
  # add_index "message_group", ["Name"], name: "UIDX_Class_MessageGroup", unique: true, using: :btree

  create_table "migrateeids", id: false, force: :cascade do |t|
    t.integer "eid", limit: 4
  end

  create_table "missingpronunciation", id: false, force: :cascade do |t|
    t.string  "Word",             limit: 64, null: false
    t.integer "TrainingField_ID", limit: 1,  null: false
    t.integer "Requests",         limit: 1,  null: false
  end

  add_index "missingpronunciation", ["TrainingField_ID"], name: "FK_MissingPronunciation_TrainingField_ID", using: :btree

  create_table "module", primary_key: "ID", force: :cascade do |t|
    t.string  "Name",                       limit: 64,              null: false
    t.string  "Description",                limit: 64, default: ""
    t.integer "Partnership_ID",             limit: 2
    t.boolean "ExercisesCountTowardGrade",                          null: false
    t.string  "Folder",                     limit: 64
    t.integer "CopyrightWatermarkGroup_ID", limit: 2
  end

  add_index "module", ["CopyrightWatermarkGroup_ID"], name: "FK_Module_CopyrightWatermarkGroup_ID", using: :btree
  add_index "module", ["Description"], name: "UIDX_Module_Description", unique: true, using: :btree
  add_index "module", ["Name"], name: "IDX_Module_Name", using: :btree

  create_table "module_map", primary_key: "Module_Map_ID", force: :cascade do |t|
    t.string   "Name",                  limit: 64,  null: false
    t.string   "Description",           limit: 500, null: false
    t.integer  "From_ModuleVersion_ID", limit: 2,   null: false
    t.integer  "To_ModuleVersion_ID",   limit: 2,   null: false
    t.integer  "Last_Update_User_ID",   limit: 4,   null: false
    t.datetime "Last_Update_DT"
  end

  add_index "module_map", ["From_ModuleVersion_ID"], name: "FK_Module_Map_FromModuleVersionID", using: :btree
  add_index "module_map", ["Last_Update_User_ID"], name: "FK_Module_Map_LastUpdateUserID", using: :btree
  add_index "module_map", ["To_ModuleVersion_ID"], name: "FK_Module_Map_ToModuleVersionID", using: :btree

  create_table "module_map_page_info", primary_key: "Module_Map_Page_Info_ID", force: :cascade do |t|
    t.integer "From_Page_ID",    limit: 3, null: false
    t.integer "From_PageOffset", limit: 2, null: false
    t.integer "To_Page_ID",      limit: 3
    t.integer "To_PageOffset",   limit: 2
    t.integer "Module_Map_ID",   limit: 8
  end

  add_index "module_map_page_info", ["From_Page_ID"], name: "FK_ModuleMapPageInfo_FromPageID", using: :btree
  add_index "module_map_page_info", ["Module_Map_ID"], name: "FK_ModuleMapPageInfo_ModuleMapID", using: :btree
  add_index "module_map_page_info", ["To_Page_ID"], name: "FK_ModuleMapPageInfo_ToPageID", using: :btree

  create_table "modulebranding", id: false, force: :cascade do |t|
    t.integer "Module_ID",                 limit: 2,   null: false
    t.integer "ProgramBranding_ID",        limit: 2,   null: false
    t.string  "Name",                      limit: 64
    t.string  "Description",               limit: 128
    t.boolean "ExercisesCountTowardGrade"
  end

  add_index "modulebranding", ["Name"], name: "IDX_ModuleBranding_Name", using: :btree
  add_index "modulebranding", ["ProgramBranding_ID"], name: "FK_ModuleBranding_ProgramBranding_ID", using: :btree

  create_table "moduleversion", primary_key: "ID", force: :cascade do |t|
    t.integer "Module_ID",                limit: 2,                           null: false
    t.decimal "Version",                              precision: 3, scale: 1, null: false
    t.date    "StartDate",                                                    null: false
    t.string  "NewEnrollmentLogic",       limit: 255,                         null: false
    t.float   "EstimatedCompletionHours", limit: 53,                          null: false
    t.boolean "IncludeInStudyPlanner",                                        null: false
  end

  add_index "moduleversion", ["Module_ID", "Version"], name: "UIDX_ModuleVersion_Module_ID_Version", unique: true, using: :btree

  create_table "moduleversionaccess", id: false, force: :cascade do |t|
    t.integer  "Enrollment_ID",         limit: 4,             null: false
    t.integer  "ModuleVersion_ID",      limit: 2,             null: false
    t.string   "AccessType",            limit: 9,             null: false
    t.integer  "StatusChangeReason_ID", limit: 1,             null: false
    t.datetime "Modified",                                    null: false
    t.integer  "ModifiedBy_User_ID",    limit: 4,             null: false
    t.integer  "IsDelay",               limit: 4, default: 0, null: false
  end

  add_index "moduleversionaccess", ["ModifiedBy_User_ID"], name: "FK_ModuleVersionAccess_ModifiedBy_User_ID", using: :btree
  add_index "moduleversionaccess", ["ModuleVersion_ID"], name: "FK_ModuleVersionAccess_ModuleVersion_ID", using: :btree
  add_index "moduleversionaccess", ["StatusChangeReason_ID"], name: "FK_ModuleVersionAccess_StatusChangeReason_ID", using: :btree

  create_table "moduleversionaccesshistory", primary_key: "ID", force: :cascade do |t|
    t.integer  "Enrollment_ID",         limit: 4, null: false
    t.integer  "ModuleVersion_ID",      limit: 2, null: false
    t.string   "AccessType",            limit: 9, null: false
    t.integer  "StatusChangeReason_ID", limit: 1, null: false
    t.datetime "Modified",                        null: false
    t.integer  "ModifiedBy_User_ID",    limit: 4, null: false
  end

  add_index "moduleversionaccesshistory", ["Enrollment_ID"], name: "FK_ModuleVersionAccessHistory_Enrollment_ID", using: :btree
  add_index "moduleversionaccesshistory", ["ModifiedBy_User_ID"], name: "FK_ModuleVersionAccessHistory_ModifiedBy_User_ID", using: :btree
  add_index "moduleversionaccesshistory", ["ModuleVersion_ID"], name: "FK_ModuleVersionAccessHistory_ModuleVersion_ID", using: :btree
  add_index "moduleversionaccesshistory", ["StatusChangeReason_ID"], name: "FK_ModuleVersionAccessHistory_StatusChangeReason_ID", using: :btree

  create_table "moduleversioncontents", id: false, force: :cascade do |t|
    t.integer "ModuleVersion_ID", limit: 2, null: false
    t.integer "SortOrder",        limit: 2, null: false
    t.integer "UnitVersion_ID",   limit: 2, null: false
  end

  add_index "moduleversioncontents", ["UnitVersion_ID"], name: "FK_ModuleVersionContents_UnitVersion_ID", using: :btree

  create_table "moduleversionupgrade", id: false, force: :cascade do |t|
    t.integer "Old_ModuleVersion_ID", limit: 2,   null: false
    t.integer "New_ModuleVersion_ID", limit: 2,   null: false
    t.string  "UpgradeLogic",         limit: 128, null: false
  end

  add_index "moduleversionupgrade", ["New_ModuleVersion_ID"], name: "FK_ModuleVersionUpgrade_New_ModuleVersion_ID", using: :btree

  create_table "mycaa_old_enrollment_history", id: false, force: :cascade do |t|
    t.integer "Old_Enrollment_ID", limit: 4, null: false
    t.integer "New_Enrollment_ID", limit: 4, null: false
    t.integer "User_ID",           limit: 4, null: false
  end

  create_table "object_permissions", primary_key: "ID", force: :cascade do |t|
    t.string  "name",   limit: 128, null: false
    t.string  "object", limit: 128
    t.string  "type",   limit: 128
    t.boolean "active"
  end

  create_table "organization", primary_key: "Contact_ID", force: :cascade do |t|
    t.string  "Name",      limit: 64,             null: false
    t.integer "Is_Active", limit: 1,  default: 1, null: false
  end

  create_table "organizationindividualcontact", id: false, force: :cascade do |t|
    t.integer "Organization_ID", limit: 4,   null: false
    t.integer "Individual_ID",   limit: 4,   null: false
    t.string  "Description",     limit: 128
  end

  add_index "organizationindividualcontact", ["Individual_ID"], name: "FK_OrganizationIndividualContact_Individual_ID", using: :btree

  create_table "page", primary_key: "ID", force: :cascade do |t|
    t.integer "Module_ID",        limit: 2
    t.string  "Name",             limit: 64,  null: false
    t.integer "Activity_ID",      limit: 1,   null: false
    t.string  "Title",            limit: 128, null: false
    t.integer "RecordingType_ID", limit: 1,   null: false
  end

  add_index "page", ["Activity_ID"], name: "FK_Page_Activity_ID", using: :btree
  add_index "page", ["Module_ID"], name: "FK_Page_Module_ID", using: :btree
  add_index "page", ["Name"], name: "UIDX_Page_Name", unique: true, using: :btree
  add_index "page", ["RecordingType_ID"], name: "FK_Page_RecordingType_ID", using: :btree
  add_index "page", ["Title"], name: "IDX_Page_Title", using: :btree

  create_table "pageoffsetlookup", id: false, force: :cascade do |t|
    t.integer "ModuleVersion_ID",                limit: 2, null: false
    t.integer "PageOffset",                      limit: 2, null: false
    t.integer "ModuleVersionContents_SortOrder", limit: 2, null: false
    t.integer "UnitVersionContents_SortOrder",   limit: 2, null: false
    t.integer "Page_ID",                         limit: 3, null: false
  end

  add_index "pageoffsetlookup", ["Page_ID"], name: "FK_PageOffsetLookup_Page_ID", using: :btree

  create_table "pagerawscore", id: false, force: :cascade do |t|
    t.integer "Enrollment_ID",    limit: 4, null: false
    t.integer "ModuleVersion_ID", limit: 2, null: false
    t.integer "PageOffset",       limit: 2, null: false
    t.integer "InitialScore",     limit: 1, null: false
    t.date    "InitialDate",                null: false
    t.time    "InitialTime",                null: false
    t.integer "BestScore",        limit: 1, null: false
    t.date    "BestDate",                   null: false
    t.time    "BestTime",                   null: false
    t.integer "SubmissionCount",  limit: 1, null: false
    t.integer "RunningTally",     limit: 2, null: false
  end

  add_index "pagerawscore", ["ModuleVersion_ID"], name: "FK_PageRawScore_ModuleVersion_ID", using: :btree

  create_table "pagerawscoredeleted", id: false, force: :cascade do |t|
    t.integer "Enrollment_ID",    limit: 4, null: false
    t.integer "ModuleVersion_ID", limit: 2, null: false
    t.integer "PageOffset",       limit: 2, null: false
    t.integer "InitialScore",     limit: 1, null: false
    t.date    "InitialDate",                null: false
    t.time    "InitialTime",                null: false
    t.integer "BestScore",        limit: 1, null: false
    t.date    "BestDate",                   null: false
    t.time    "BestTime",                   null: false
    t.integer "SubmissionCount",  limit: 1, null: false
    t.integer "RunningTally",     limit: 2, null: false
  end

  add_index "pagerawscoredeleted", ["ModuleVersion_ID"], name: "FK_PageRawScoreDeleted_ModuleVersion_ID", using: :btree

  create_table "pagescore", id: false, force: :cascade do |t|
    t.integer "Enrollment_ID",     limit: 4, null: false
    t.integer "ModuleVersion_ID",  limit: 2, null: false
    t.integer "PageOffset",        limit: 2, null: false
    t.integer "InitialScore",      limit: 1, null: false
    t.date    "InitialDate",                 null: false
    t.time    "InitialTime",                 null: false
    t.integer "BestScore",         limit: 1, null: false
    t.date    "BestDate",                    null: false
    t.time    "BestTime",                    null: false
    t.integer "SubmissionCount",   limit: 1, null: false
    t.integer "RunningTally",      limit: 2, null: false
    t.integer "PassingSubmission", limit: 1
    t.date    "PassingDate"
    t.time    "PassingTime"
  end

  add_index "pagescore", ["ModuleVersion_ID"], name: "FK_PageScore_ModuleVersion_ID", using: :btree

  create_table "pagescoredeleted", id: false, force: :cascade do |t|
    t.integer "Enrollment_ID",     limit: 4, null: false
    t.integer "ModuleVersion_ID",  limit: 2, null: false
    t.integer "PageOffset",        limit: 2, null: false
    t.integer "InitialScore",      limit: 1, null: false
    t.date    "InitialDate",                 null: false
    t.time    "InitialTime",                 null: false
    t.integer "BestScore",         limit: 1, null: false
    t.date    "BestDate",                    null: false
    t.time    "BestTime",                    null: false
    t.integer "SubmissionCount",   limit: 1, null: false
    t.integer "RunningTally",      limit: 2, null: false
    t.integer "PassingSubmission", limit: 1
    t.date    "PassingDate"
    t.time    "PassingTime"
  end

  add_index "pagescoredeleted", ["ModuleVersion_ID"], name: "FK_PageScoreDeleted_ModuleVersion_ID", using: :btree

  create_table "pagetimespent", id: false, force: :cascade do |t|
    t.integer "Enrollment_ID",    limit: 4, null: false
    t.integer "ModuleVersion_ID", limit: 2, null: false
    t.integer "PageOffset",       limit: 2, null: false
    t.integer "SecondsSpent",     limit: 3, null: false
  end

  add_index "pagetimespent", ["ModuleVersion_ID"], name: "FK_PageTimeSpent_ModuleVersion_ID", using: :btree

  create_table "pagetimespentdeleted", id: false, force: :cascade do |t|
    t.integer "Enrollment_ID",    limit: 4, null: false
    t.integer "ModuleVersion_ID", limit: 2, null: false
    t.integer "PageOffset",       limit: 2, null: false
    t.integer "SecondsSpent",     limit: 3, null: false
  end

  add_index "pagetimespentdeleted", ["ModuleVersion_ID"], name: "FK_PageTimeSpentDeleted_ModuleVersion_ID", using: :btree

  create_table "pagetimespentlog", id: false, force: :cascade do |t|
    t.integer "Enrollment_ID",     limit: 4, null: false
    t.integer "TotalSecondsSpent", limit: 4, null: false
    t.date    "LogDate",                     null: false
  end

  create_table "panel", primary_key: "Panel_ID", force: :cascade do |t|
    t.string "Name", limit: 50, null: false
  end

  add_index "panel", ["Name"], name: "UIDX_Panel_Name", unique: true, using: :btree

  create_table "partner", primary_key: "ID", force: :cascade do |t|
    t.integer "Organization_Contact_ID",     limit: 4,                  null: false
    t.string  "HomeURL",                     limit: 64,                 null: false
    t.string  "Welcome",                     limit: 45,                 null: false
    t.string  "LogoURL",                     limit: 64,                 null: false
    t.integer "ThemeInfo_ID",                limit: 2,                  null: false
    t.boolean "ShowStudyPlanner",                       default: true,  null: false
    t.boolean "ShowStudentResources",                   default: true,  null: false
    t.boolean "ShowPublications",                       default: true,  null: false
    t.integer "ShowStudentMessage",          limit: 1,  default: 1,     null: false
    t.boolean "DoExtensionNotification",                default: false, null: false
    t.boolean "GetsPlacementDirectServices",            default: true,  null: false
  end

  add_index "partner", ["Organization_Contact_ID"], name: "UIDX_Partner_Organization_Contact_ID", unique: true, using: :btree
  add_index "partner", ["ThemeInfo_ID"], name: "FK_Partner_ThemeInfo_ID", using: :btree

  create_table "partnership", primary_key: "ID", force: :cascade do |t|
    t.integer "Partner_ID",                   limit: 2,  null: false
    t.integer "PartnershipType_ID",           limit: 1,  null: false
    t.string  "SalesforcePartnerAccountGuid", limit: 32
  end

  add_index "partnership", ["Partner_ID", "PartnershipType_ID"], name: "UIDX_Partner_Partner_ID_PartnershipType_ID", unique: true, using: :btree
  add_index "partnership", ["PartnershipType_ID"], name: "FK_Partnership_PartnershipType_ID", using: :btree
  add_index "partnership", ["SalesforcePartnerAccountGuid"], name: "IDX_Partnership_SalesforcePartnerAccountGuid", using: :btree

  create_table "partnership_announcementflag", id: false, force: :cascade do |t|
    t.integer "Partnership_ID",      limit: 2, null: false
    t.integer "AnnouncementFlag_ID", limit: 1, null: false
    t.boolean "IsWanted",                      null: false
  end

  add_index "partnership_announcementflag", ["AnnouncementFlag_ID"], name: "FK_Partnership_AnnouncementFlag_AnnouncementFlag_ID", using: :btree

  create_table "partnershipacademiccalendar", id: false, force: :cascade do |t|
    t.integer "Partnership_ID", limit: 2,  null: false
    t.string  "Term",           limit: 32, null: false
    t.date    "StartDate",                 null: false
    t.date    "EndDate",                   null: false
  end

  create_table "partnershipannouncement", primary_key: "ID", force: :cascade do |t|
    t.integer "Announcement_ID",    limit: 4, null: false
    t.integer "Partnership_ID",     limit: 2, null: false
    t.integer "ProgramBranding_ID", limit: 2
  end

  add_index "partnershipannouncement", ["Announcement_ID"], name: "FK_PartnershipAnnouncement_Announcement_ID", using: :btree
  add_index "partnershipannouncement", ["Partnership_ID"], name: "FK_PartnershipAnnouncement_Partnership_ID", using: :btree
  add_index "partnershipannouncement", ["ProgramBranding_ID"], name: "FK_PartnershipAnnouncement_ProgramBranding_ID", using: :btree

  create_table "partnershiptype", primary_key: "ID", force: :cascade do |t|
    t.string "Name", limit: 32, null: false
  end

  add_index "partnershiptype", ["Name"], name: "UIDX_PartnershipType_Name", unique: true, using: :btree

  create_table "penscommand", primary_key: "pens_command_id", force: :cascade do |t|
    t.string   "update_by",           limit: 32,                       null: false
    t.datetime "update_dt",                                            null: false
    t.string   "pens_package_type",   limit: 10,                       null: false
    t.string   "pens_package_id",     limit: 2000,                     null: false
    t.string   "pens_client",         limit: 100,                      null: false
    t.string   "pens_system_user_id", limit: 100
    t.string   "pens_step",           limit: 100,                      null: false
    t.integer  "internal_step",       limit: 4,                        null: false
    t.integer  "should_process",      limit: 4,                        null: false
    t.string   "pens_command",        limit: 7,                        null: false
    t.text     "pens_serialized",     limit: 4294967295,               null: false
    t.integer  "failedCount",         limit: 4,                        null: false
    t.datetime "processAfter",                                         null: false
    t.string   "lock_id",             limit: 50,         default: "'", null: false
  end

  add_index "penscommand", ["internal_step", "lock_id", "should_process"], name: "IX_PensCommand", using: :btree

  create_table "penscommandscormpackage", id: false, force: :cascade do |t|
    t.string   "update_by",           limit: 32,                 null: false
    t.datetime "update_dt",                                      null: false
    t.integer  "pens_command_id",     limit: 4,                  null: false
    t.integer  "scorm_package_id",    limit: 4,                  null: false
    t.string   "external_package_id", limit: 2000, default: "'", null: false
  end

  add_index "penscommandscormpackage", ["scorm_package_id"], name: "FK_PensCommandScormPackage_2", using: :btree
  add_index "penscommandscormpackage", ["scorm_package_id"], name: "IX_PCSP_package_id", using: :btree

  create_table "phone", primary_key: "ID", force: :cascade do |t|
    t.integer "Contact_ID", limit: 4,  null: false
    t.string  "Purpose",    limit: 17, null: false
    t.string  "Number",     limit: 32, null: false
  end

  add_index "phone", ["Contact_ID", "Purpose"], name: "UIDX_Phone_Contact_ID_Purpose", unique: true, using: :btree

  create_table "placementdirectspotlight", primary_key: "TrainingField_ID", force: :cascade do |t|
    t.text "GraduateSpotLight", limit: 65535
    t.text "EmployerSpotLight", limit: 65535
  end

  create_table "placementdirectwelcomemessage", id: false, force: :cascade do |t|
    t.string  "Subject",          limit: 255,   null: false
    t.text    "Message",          limit: 65535, null: false
    t.integer "TrainingField_ID", limit: 1,     null: false
    t.string  "Level",            limit: 8,     null: false
    t.string  "GraduationLevel",  limit: 10,    null: false
    t.string  "BccEmailAlias",    limit: 64,    null: false
  end

  create_table "program", primary_key: "ID", force: :cascade do |t|
    t.integer "TrainingField_ID", limit: 1,                   null: false
    t.string  "name",             limit: 128
    t.string  "Description",      limit: 64,                  null: false
    t.integer "Partnership_ID",   limit: 2
    t.integer "License_ID",       limit: 1,                   null: false
    t.string  "DefaultGraphic",   limit: 64,                  null: false
    t.integer "ProgramType_ID",   limit: 1,                   null: false
    t.integer "Final_Program_ID", limit: 2
    t.integer "Creator_User_ID",  limit: 4
    t.boolean "IsDemo",                       default: false, null: false
  end

  add_index "program", ["Creator_User_ID"], name: "FK_Program_User_Creator_User_ID", using: :btree
  add_index "program", ["Final_Program_ID"], name: "FK_Program_Program_Final_Program_ID", using: :btree
  add_index "program", ["License_ID"], name: "FK_Program_License_ID", using: :btree
  add_index "program", ["Partnership_ID"], name: "FK_Program_Partnership_ID", using: :btree
  add_index "program", ["ProgramType_ID"], name: "FK_Program_ProgramType", using: :btree
  add_index "program", ["TrainingField_ID"], name: "FK_Program_TrainingField_ID", using: :btree

  create_table "program_final_exam", primary_key: "Program_Final_Exam_ID", force: :cascade do |t|
    t.integer "Duration",          limit: 2,              null: false
    t.integer "Passing_Threshold", limit: 1, default: 85, null: false
    t.integer "Program_ID",        limit: 2,              null: false
  end

  add_index "program_final_exam", ["Program_ID"], name: "FK_ProgramFinalExam_Program_ID", using: :btree

  create_table "programbranding", primary_key: "ID", force: :cascade do |t|
    t.integer "Program_ID",                          limit: 2,                          null: false
    t.integer "Partnership_ID",                      limit: 2,                          null: false
    t.string  "Name",                                limit: 128
    t.string  "Description",                         limit: 128,                        null: false
    t.string  "LogoURL",                             limit: 64,                         null: false
    t.string  "OptionalLogoURL",                     limit: 64
    t.integer "ThemeInfo_ID",                        limit: 2,                          null: false
    t.integer "ProgramCustomization_ID",             limit: 2,                          null: false
    t.integer "DefaultEndDateMonthsOut",             limit: 2,   default: 12
    t.integer "HoursToComplete",                     limit: 2
    t.string  "Graphic",                             limit: 64,                         null: false
    t.string  "AddEnrollmentEmailAddress",           limit: 255
    t.integer "AddEnrollmentDefaultEmailMessage_ID", limit: 4
    t.integer "BlockUpdateDefaultEmailMessage_ID",   limit: 4
    t.boolean "EnrollOnAcademicCalendar",                        default: false,        null: false
    t.boolean "SendLoginEmailToStudent",                         default: true,         null: false
    t.string  "WhoPurchasesExtensions",              limit: 7,   default: "student",    null: false
    t.boolean "StudentRequestsMaterials",                        default: true,         null: false
    t.string  "DemoEnrollNowPhoneNumber",            limit: 32
    t.string  "DemoEnrollNowURL",                    limit: 128
    t.integer "EmailGradedPageFrequency",            limit: 1,   default: 0
    t.string  "MarketingURL",                        limit: 128
    t.integer "ShowErrorsPercent",                   limit: 4
    t.integer "DisplayOnlyFullAccessModules",        limit: 1,   default: 0,            null: false
    t.integer "ProgramBranding_Threshold_ID",        limit: 4,   default: 1,            null: false
    t.string  "ShowCertBy",                          limit: 10,  default: "compreport", null: false
    t.string  "BccEmailAddress",                     limit: 255
    t.integer "AlwaysShowHints",                     limit: 1,   default: 0,            null: false
    t.string  "UpdateType",                          limit: 5
    t.date    "KickOffDate"
  end

  add_index "programbranding", ["AddEnrollmentDefaultEmailMessage_ID"], name: "FK_ProgramBranding_AddEnrollmentDefaultEmailMessage_ID", using: :btree
  add_index "programbranding", ["BlockUpdateDefaultEmailMessage_ID"], name: "FK_Message_ProgramBranding_BlockUpdateDefaultEmailMessage_ID", using: :btree
  add_index "programbranding", ["Partnership_ID"], name: "FK_ProgramBranding_Partnership_ID", using: :btree
  add_index "programbranding", ["ProgramBranding_Threshold_ID"], name: "ProgramBranding_Threshold_ID", using: :btree
  add_index "programbranding", ["ProgramCustomization_ID"], name: "FK_ProgramBranding_ProgramCustomization_ID", using: :btree
  add_index "programbranding", ["Program_ID"], name: "FK_ProgramBranding_Program_ID", using: :btree
  add_index "programbranding", ["ThemeInfo_ID"], name: "FK_ProgramBranding_ThemeInfo_ID", using: :btree

  create_table "programbranding_certificate", force: :cascade do |t|
    t.integer "ProgramBranding_ID", limit: 2, null: false
    t.integer "Certificate_ID",     limit: 4, null: false
  end

  create_table "programbranding_threshold", primary_key: "ID", force: :cascade do |t|
    t.integer "Acceptable", limit: 4, default: 85,  null: false
    t.integer "Excellent",  limit: 4, default: 95,  null: false
    t.integer "HighHonors", limit: 4, default: 101, null: false
    t.integer "Is_Default", limit: 4, default: 0,   null: false
  end

  create_table "programbrandingaddon", primary_key: "ID", force: :cascade do |t|
    t.integer "Addon_ID",           limit: 2,                         null: false
    t.integer "ProgramBranding_ID", limit: 2,                         null: false
    t.decimal "Price",                        precision: 5, scale: 2
  end

  add_index "programbrandingaddon", ["Addon_ID"], name: "FK_ProgramBrandingAddon_Addon", using: :btree
  add_index "programbrandingaddon", ["ProgramBranding_ID"], name: "FK_ProgramBrandingAddon_ProgramBranding", using: :btree

  create_table "programbrandingblockset", id: false, force: :cascade do |t|
    t.integer "ProgramBranding_ID", limit: 2, null: false
    t.integer "BlockSet_ID",        limit: 2, null: false
  end

  add_index "programbrandingblockset", ["BlockSet_ID"], name: "FK_ProgramBrandingBlockSet_BlockSet_ID", using: :btree

  create_table "programbrandingbundleoverride", id: false, force: :cascade do |t|
    t.integer "ProgramBranding_ID", limit: 2,   default: 0,  null: false
    t.integer "parentVersion_ID",   limit: 4,   default: 0,  null: false
    t.integer "childVersion_ID",    limit: 4,   default: 0,  null: false
    t.string  "Fieldkey",           limit: 128, default: "", null: false
    t.string  "Value",              limit: 256
  end

  create_table "programbrandingprice", primary_key: "ID", force: :cascade do |t|
    t.integer "ProgramBranding_ID", limit: 2,                         null: false
    t.decimal "Price",                        precision: 6, scale: 2, null: false
  end

  add_index "programbrandingprice", ["ProgramBranding_ID"], name: "FK_ProgramBrandingPrice_ProgramBranding", using: :btree

  create_table "programbundle", id: false, force: :cascade do |t|
    t.integer "parentProgramVersionId", limit: 4,  null: false
    t.integer "childProgramVersionId",  limit: 4,  null: false
    t.integer "child_order",            limit: 4,  null: false
    t.boolean "isActive"
    t.integer "blocksetId",             limit: 4
    t.string  "type",                   limit: 11
  end

  create_table "programcustomization", primary_key: "ID", force: :cascade do |t|
    t.string  "Name",                              limit: 64, null: false
    t.integer "Support_WebsiteContactInfo_ID",     limit: 2,  null: false
    t.integer "Shipping_WebsiteContactInfo_ID",    limit: 2
    t.integer "TechSupport_WebsiteContactInfo_ID", limit: 2,  null: false
    t.string  "ForumURL",                          limit: 64
    t.string  "ChatroomURL",                       limit: 64
    t.integer "ThresholdCollection_ID",            limit: 2,  null: false
    t.string  "ScoreThatCountsTowardGrade",        limit: 7,  null: false
  end

  add_index "programcustomization", ["Shipping_WebsiteContactInfo_ID"], name: "FK_ProgramCustomization_Shipping_WebsiteContactInfo_ID", using: :btree
  add_index "programcustomization", ["Support_WebsiteContactInfo_ID"], name: "FK_ProgramCustomization_Support_WebsiteContactInfo_ID", using: :btree
  add_index "programcustomization", ["TechSupport_WebsiteContactInfo_ID"], name: "FK_ProgramCustomization_TechSupport_WebsiteContactInfo_ID", using: :btree
  add_index "programcustomization", ["ThresholdCollection_ID"], name: "FK_ProgramCustomization_ThresholdCollection_ID", using: :btree

  create_table "programtype", primary_key: "ID", force: :cascade do |t|
    t.string "Type",        limit: 32
    t.string "Description", limit: 255
  end

  create_table "programversion", primary_key: "ID", force: :cascade do |t|
    t.integer  "Program_ID",         limit: 2,                           null: false
    t.decimal  "Version",                        precision: 3, scale: 1, null: false
    t.date     "StartDate",                                              null: false
    t.string   "NewEnrollmentLogic", limit: 512,                         null: false
    t.datetime "KickOffDate"
  end

  add_index "programversion", ["Program_ID", "Version"], name: "UIDX_ProgramVersion_Program_ID_Version", unique: true, using: :btree

  create_table "programversionaccesshistory", primary_key: "ID", force: :cascade do |t|
    t.integer  "Enrollment_ID",         limit: 4, null: false
    t.integer  "ProgramVersion_ID",     limit: 2, null: false
    t.boolean  "CanAccessProgram",                null: false
    t.date     "StartDate"
    t.date     "EndDate"
    t.integer  "StatusChangeReason_ID", limit: 1, null: false
    t.datetime "Modified",                        null: false
    t.integer  "ModifiedBy_User_ID",    limit: 4, null: false
  end

  add_index "programversionaccesshistory", ["Enrollment_ID"], name: "FK_ProgramVersionAccessHistory_Enrollment_ID", using: :btree
  add_index "programversionaccesshistory", ["ModifiedBy_User_ID"], name: "FK_ProgramVersionAccessHistory_ModifiedBy_User_ID", using: :btree
  add_index "programversionaccesshistory", ["ProgramVersion_ID"], name: "FK_ProgramVersionAccessHistory_ProgramVersion_ID", using: :btree
  add_index "programversionaccesshistory", ["StatusChangeReason_ID"], name: "FK_ProgramVersionAccessHistory_StatusChangeReason_ID", using: :btree

  create_table "programversioncontents", id: false, force: :cascade do |t|
    t.integer "ProgramVersion_ID", limit: 2, null: false
    t.integer "SortOrder",         limit: 2, null: false
    t.integer "Module_ID",         limit: 2, null: false
  end

  add_index "programversioncontents", ["Module_ID"], name: "FK_ProgramVersionContents_Module_ID", using: :btree
  add_index "programversioncontents", ["ProgramVersion_ID", "Module_ID"], name: "UIDX_ProgramVersionContents_ProgramVersion_ID_Module_ID", unique: true, using: :btree

  create_table "programversionupgrade", id: false, force: :cascade do |t|
    t.integer "Old_ProgramVersion_ID", limit: 2,   null: false
    t.integer "New_ProgramVersion_ID", limit: 2,   null: false
    t.string  "UpgradeLogic",          limit: 128, null: false
  end

  add_index "programversionupgrade", ["New_ProgramVersion_ID"], name: "FK_ProgramVersionUpgrade_New_ProgramVersion_ID", using: :btree

  create_table "promocode", primary_key: "ID", force: :cascade do |t|
    t.string   "Description",     limit: 256
    t.string   "Code",            limit: 32
    t.text     "Filters",         limit: 65535
    t.float    "DiscountAmount",  limit: 24
    t.string   "DiscountType",    limit: 7
    t.integer  "IsValid",         limit: 1,     default: 1,     null: false
    t.datetime "CreatedDate"
    t.datetime "UpdatedDate"
    t.integer  "CreatedBy",       limit: 4
    t.integer  "UpdatedBy",       limit: 4
    t.boolean  "WaiveReactivate",               default: false
  end

  add_index "promocode", ["Code"], name: "Code", unique: true, using: :btree

  create_table "promocodeusage", primary_key: "ID", force: :cascade do |t|
    t.integer  "Enrollment_ID",              limit: 4
    t.string   "EnteredText",                limit: 32
    t.datetime "UsedDate"
    t.string   "UsageStatus",                limit: 256
    t.integer  "EnrollmentDaysToExpiration", limit: 2
  end

  add_index "promocodeusage", ["Enrollment_ID"], name: "FK_PromoCodeUsage_EnrollmentID", using: :btree

  create_table "pronunciation", primary_key: "ID", force: :cascade do |t|
    t.string  "Word",     limit: 64,  null: false
    t.string  "Path",     limit: 255, null: false
    t.boolean "IsActive",             null: false
  end

  add_index "pronunciation", ["Word"], name: "IDX_Pronunciation_Word", using: :btree

  create_table "pronunciationcategory", id: false, force: :cascade do |t|
    t.integer "Pronunciation_ID", limit: 3, null: false
    t.integer "Category_ID",      limit: 2, null: false
  end

  add_index "pronunciationcategory", ["Category_ID"], name: "FK_PronunciationCategory_Category_ID", using: :btree

  create_table "question", primary_key: "Question_ID", force: :cascade do |t|
    t.integer  "Question_Group_ID", limit: 8,                    null: false
    t.text     "Answer",            limit: 65535,                null: false
    t.integer  "Version",           limit: 2,                    null: false
    t.integer  "QDB_QuestionID",    limit: 4,                    null: false
    t.integer  "Total_Points",      limit: 2
    t.datetime "Last_Update_DT"
    t.datetime "Create_DT",                                      null: false
    t.boolean  "Status",                          default: true, null: false
  end

  add_index "question", ["Question_Group_ID"], name: "FK_Question_QuestionGroup_Question_Group_ID", using: :btree

  create_table "question_answer", primary_key: "Question_Answer_ID", force: :cascade do |t|
    t.integer "Question_ID", limit: 8,     null: false
    t.text    "Answer",      limit: 65535, null: false
  end

  add_index "question_answer", ["Question_ID"], name: "FK_QuestionAnswer_Question_Question_ID", using: :btree

  create_table "question_content", primary_key: "Question_Content_ID", force: :cascade do |t|
    t.integer "Question_Segment_ID", limit: 8,     null: false
    t.string  "Value",               limit: 5000, null: false
    t.integer "Layout_Order",        limit: 2,     null: false
  end

  add_index "question_content", ["Question_Segment_ID"], name: "FK_QuestionContent_QuestionSegment_Question_Segment_ID", using: :btree

  create_table "question_group", primary_key: "Question_Group_ID", force: :cascade do |t|
    t.integer "Program_ID",              limit: 2,                  null: false
    t.string  "Title",                   limit: 500,                null: false
    t.string  "Instruction",             limit: 500,                null: false
    t.integer "Layout_Order",            limit: 2,                  null: false
    t.integer "Required_Question_Count", limit: 2,                  null: false
    t.string  "Group_Format",            limit: 50,                 null: false
    t.integer "QDB_QGroupID",            limit: 4,                  null: false
    t.boolean "Status",                              default: true, null: false
  end

  add_index "question_group", ["Program_ID"], name: "FK_QuestionGroup_Program_ID", using: :btree

  create_table "question_segment", primary_key: "Question_Segment_ID", force: :cascade do |t|
    t.integer "Question_ID",              limit: 8,     null: false
    t.integer "Question_Segment_Type_ID", limit: 8,     null: false
    t.integer "Layout_Order",             limit: 2,     null: false
    t.integer "Newline",                  limit: 2
    t.string  "List_Orientation",         limit: 10
    t.integer "Blanks",                   limit: 4
    t.string  "Size",                     limit: 10
    t.string  "Max_Length",               limit: 10
    t.integer "Cols",                     limit: 2
    t.integer "Rows",                     limit: 2
    t.integer "CanAdd",                   limit: 2
    t.text    "PreFill",                  limit: 65535
  end

  add_index "question_segment", ["Question_ID"], name: "FK_QuestionSegment_Question_Question_ID", using: :btree
  add_index "question_segment", ["Question_Segment_Type_ID"], name: "FK_QustnSgmnt_QustnSgmntType_Question_Sement_Type_ID", using: :btree

  create_table "question_segment_type", primary_key: "Question_Segment_Type_ID", force: :cascade do |t|
    t.string "Name", limit: 500, null: false
  end

  create_table "questiongroup", primary_key: "ID", force: :cascade do |t|
    t.integer "Partnership_ID",  limit: 2
    t.string  "Context",         limit: 128,      default: "What training program(s) is this group of questions related to?",                                             null: false
    t.integer "ContextSequence", limit: 1,        default: 0,                                                                                                             null: false
    t.integer "ContextPoolQty",  limit: 2,        default: 0,                                                                                                             null: false
    t.string  "Title",           limit: 128,      default: "Short external name for this group; use capitalization for titles",                                           null: false
    t.string  "Description",     limit: 255,      default: "What is the composition of this question group or pool in terms of subject, difficulty, requirements, etc.?", null: false
    t.text    "Instructions",    limit: 16777215,                                                                                                                         null: false
    t.integer "Discontinued",    limit: 1,        default: 0,                                                                                                             null: false
    t.integer "Status",          limit: 4,                                                                                                                                null: false
  end

  add_index "questiongroup", ["Discontinued"], name: "QuestionGroup_Discontinued", using: :btree
  add_index "questiongroup", ["Partnership_ID"], name: "questiongroup_ibfk_1", using: :btree

  create_table "questiongroupcontents", id: false, force: :cascade do |t|
    t.integer "QuestionGroup_ID", limit: 4, null: false
    t.integer "SortOrder",        limit: 1, null: false
    t.integer "Question_ID",      limit: 8, null: false
  end

  add_index "questiongroupcontents", ["QuestionGroup_ID"], name: "Stage_ID", using: :btree
  add_index "questiongroupcontents", ["Question_ID"], name: "Group_ID", using: :btree
  add_index "questiongroupcontents", ["Question_ID"], name: "OneGroupPerQuestion", unique: true, using: :btree

  create_table "questionresource", primary_key: "ID", force: :cascade do |t|
    t.integer "QuestionVersion_ID", limit: 8,                        null: false
    t.string  "Text",               limit: 5000,                    null: false
    t.integer "AnswerWeight",       limit: 1
    t.string  "ResourceIndex",      limit: 2
    t.string  "Type",               limit: 19,    default: "Answer", null: false
    t.string  "Details",            limit: 100
  end

  add_index "questionresource", ["QuestionVersion_ID"], name: "QuestionVersion_ID", using: :btree

  create_table "questiontag", primary_key: "ID", force: :cascade do |t|
    t.string   "Tag",              limit: 256
    t.integer  "Partnership_ID",   limit: 2
    t.integer  "CreatedByUser_ID", limit: 4
    t.datetime "CreatedDate"
    t.datetime "LastUpdated"
    t.boolean  "ActiveStatus"
  end

  create_table "questiontagmap", id: false, force: :cascade do |t|
    t.integer "QuestionTag_ID",     limit: 4, null: false
    t.integer "QuestionVersion_ID", limit: 8, null: false
  end

  create_table "questiontype", primary_key: "ID", force: :cascade do |t|
    t.string  "Name",        limit: 64,                 null: false
    t.string  "Description", limit: 256
    t.boolean "Active",                  default: true
  end

  add_index "questiontype", ["Name"], name: "QuestionTypeIdentifier", unique: true, using: :btree

  create_table "questionversion", primary_key: "ID", force: :cascade do |t|
    t.integer "Question_ID",  limit: 8,                 null: false
    t.string  "Text",         limit: 5000,             null: false
    t.integer "TotalPoints",  limit: 1,     default: 1, null: false
    t.integer "Version",      limit: 2
    t.integer "AllowPartial", limit: 1,     default: 1
    t.string  "Feedback",     limit: 5000
    t.string  "Instructions", limit: 5000
    t.string  "Hints",        limit: 5000
  end

  add_index "questionversion", ["Question_ID", "Version"], name: "Question_ID_2", using: :btree
  add_index "questionversion", ["Question_ID"], name: "Question_ID", using: :btree

  create_table "recipe_interactions", primary_key: "statement_id", force: :cascade do |t|
    t.string   "update_by",                 limit: 32,                                  default: "unknown", null: false
    t.datetime "update_dt",                                                                                 null: false
    t.string   "actor_id",                  limit: 50,                                                      null: false
    t.binary   "actor_obj",                 limit: 65535,                                                   null: false
    t.string   "activity_id",               limit: 255,                                                     null: false
    t.string   "interaction_type",          limit: 50,                                                      null: false
    t.string   "completion",                limit: 20
    t.string   "success",                   limit: 20
    t.decimal  "score",                                        precision: 10, scale: 7, default: 0.0
    t.string   "duration",                  limit: 20
    t.datetime "date"
    t.string   "app_id",                    limit: 64,                                                      null: false
    t.string   "sort_string",               limit: 295,                                                     null: false
    t.text     "correct_resp_pattern_json", limit: 4294967295
    t.text     "choices_json",              limit: 4294967295
    t.text     "scale_json",                limit: 4294967295
    t.text     "source_json",               limit: 4294967295
    t.text     "target_json",               limit: 4294967295
    t.text     "steps_json",                limit: 4294967295
  end

  add_index "recipe_interactions", ["actor_id", "activity_id"], name: "IX_Result_actor_activity", using: :btree
  add_index "recipe_interactions", ["sort_string"], name: "IX_Interactions_ss", using: :btree

  create_table "recipe_interactions_activities", force: :cascade do |t|
    t.string   "update_by",               limit: 32,  default: "unknown", null: false
    t.datetime "update_dt",                                               null: false
    t.string   "related_activity_id",     limit: 255,                     null: false
    t.string   "interaction_activity_id", limit: 255
  end

  create_table "recipe_resultssummary", id: false, force: :cascade do |t|
    t.string   "update_by",    limit: 32,                             default: "unknown", null: false
    t.datetime "update_dt",                                                               null: false
    t.string   "statement_id", limit: 36,                                                 null: false
    t.string   "actor_id",     limit: 50,                                                 null: false
    t.binary   "actor_obj",    limit: 65535,                                              null: false
    t.string   "activity_id",  limit: 255,                                                null: false
    t.string   "completion",   limit: 20
    t.string   "success",      limit: 20
    t.decimal  "score",                      precision: 10, scale: 7, default: 0.0
    t.string   "duration",     limit: 20
    t.datetime "date"
    t.string   "app_id",       limit: 64,                                                 null: false
    t.string   "sort_string",  limit: 295,                                                null: false
  end

  add_index "recipe_resultssummary", ["sort_string"], name: "IX_Result_ss", using: :btree

  create_table "recipe_video", primary_key: "statement_id", force: :cascade do |t|
    t.string   "update_by",      limit: 32,                                  default: "unknown", null: false
    t.datetime "update_dt",                                                                      null: false
    t.string   "actor_json",     limit: 1000,                                                    null: false
    t.string   "verb_id",        limit: 1000,                                                    null: false
    t.string   "object_id",      limit: 1000,                                                    null: false
    t.decimal  "starting_point",                    precision: 38, scale: 7
    t.decimal  "ending_point",                      precision: 38, scale: 7
    t.datetime "update_dt_utc"
    t.string   "app_id",         limit: 64,                                                      null: false
    t.text     "browser_info",   limit: 4294967295
  end

  create_table "recordingtype", primary_key: "ID", force: :cascade do |t|
    t.string "Name",        limit: 32,  null: false
    t.string "Description", limit: 128, null: false
  end

  add_index "recordingtype", ["Name"], name: "UIDX_RecordingType_Name", unique: true, using: :btree

  create_table "remoteloginrequest", id: false, force: :cascade do |t|
    t.string   "SessionIdentifier",      limit: 40, null: false
    t.integer  "User_ID",                limit: 4,  null: false
    t.string   "RemoteSystem",           limit: 64, null: false
    t.integer  "RemoteSystemIdentifier", limit: 4,  null: false
    t.datetime "ValidUntil"
  end

  add_index "remoteloginrequest", ["User_ID"], name: "FK_RemoteLoginRequest_User_ID", using: :btree
  add_index "remoteloginrequest", ["ValidUntil"], name: "IDX_RemoteLoginRequest_ValidUntil", using: :btree

  create_table "report", primary_key: "ID", force: :cascade do |t|
    t.string "Name",            limit: 128,   null: false
    t.text   "SelectStatement", limit: 65535, null: false
  end

  create_table "role", primary_key: "ID", force: :cascade do |t|
    t.string  "Name",         limit: 32, null: false
    t.integer "Role_Type_ID", limit: 8
  end

  add_index "role", ["Name"], name: "UIDX_Role_Name", unique: true, using: :btree
  add_index "role", ["Role_Type_ID"], name: "FK_Role_RoleType_Role_Type_ID", using: :btree

  create_table "role_group_map", id: false, force: :cascade do |t|
    t.integer "groupID", limit: 4, null: false
    t.integer "roleID",  limit: 4, null: false
  end

  create_table "role_panel", id: false, force: :cascade do |t|
    t.integer "Role_ID",      limit: 1,   null: false
    t.integer "Panel_ID",     limit: 8,   null: false
    t.string  "Display_Name", limit: 50
    t.string  "Description",  limit: 200
  end

  add_index "role_panel", ["Panel_ID"], name: "FK_RolePanel_Panel_Panel_ID", using: :btree

  create_table "role_permissions_map", id: false, force: :cascade do |t|
    t.integer "objectPermissionsID", limit: 4, null: false
    t.integer "roleID",              limit: 4, null: false
  end

  create_table "role_type", primary_key: "Role_Type_ID", force: :cascade do |t|
    t.string "Name", limit: 500, null: false
  end

  add_index "role_type", ["Name"], name: "UIDX_Role_Type_Name", unique: true, using: :btree

  create_table "rolereport", id: false, force: :cascade do |t|
    t.integer "Report_ID", limit: 4, null: false
    t.integer "Role_ID",   limit: 4, null: false
  end

  create_table "salesforce_enrollment", primary_key: "Enrollment_Salesforce_GUID", force: :cascade do |t|
    t.string  "Login",         limit: 100, null: false
    t.string  "FirstName",     limit: 100, null: false
    t.string  "LastName",      limit: 100, null: false
    t.string  "PreferredName", limit: 100
    t.string  "Email",         limit: 100
    t.integer "ProgramID",     limit: 4
  end

  create_table "salesforce_update", primary_key: "Salesforce_Update_ID", force: :cascade do |t|
    t.string "Table_Name",   limit: 100,                     null: false
    t.string "Column_Name",  limit: 100,                     null: false
    t.string "Row_ID",       limit: 100,                     null: false
    t.string "SalesforceID", limit: 500,                     null: false
    t.string "Status",       limit: 7,   default: "PENDING", null: false
  end

  create_table "scoringthreshold", primary_key: "ID", force: :cascade do |t|
    t.integer "Assessment_ID",            limit: 4
    t.integer "Stage_ID",                 limit: 4
    t.integer "Tag_ID",                   limit: 4
    t.integer "MinimumRequiredQuestions", limit: 4, default: 0
    t.integer "PercentPassThreshold",     limit: 4, default: 0
    t.integer "AutofailThreshold",        limit: 4, default: 0
    t.boolean "ShowRunningTotal",                   default: false, null: false
  end

  add_index "scoringthreshold", ["Assessment_ID"], name: "scoringthreshold_ibfk_1", using: :btree
  add_index "scoringthreshold", ["Stage_ID"], name: "scoringthreshold_ibfk_2", using: :btree
  add_index "scoringthreshold", ["Tag_ID"], name: "scoringthreshold_ibfk_3", using: :btree

  create_table "scormactivity", primary_key: "scorm_activity_id", force: :cascade do |t|
    t.string   "update_by",                      limit: 32,                                         null: false
    t.datetime "update_dt",                                                                         null: false
    t.integer  "scorm_registration_id",          limit: 4,                                          null: false
    t.integer  "scorm_object_id",                limit: 4,                                          null: false
    t.integer  "activity_progress_status",       limit: 4,                                          null: false
    t.integer  "activity_attempt_count",         limit: 4,                                          null: false
    t.integer  "attempt_progress_status",        limit: 4,                                          null: false
    t.decimal  "attempt_completion_amount",                   precision: 10, scale: 7,              null: false
    t.integer  "attempt_completion_status",      limit: 4,                                          null: false
    t.integer  "active",                         limit: 4,                                          null: false
    t.integer  "suspended",                      limit: 4,                                          null: false
    t.integer  "included",                       limit: 4,                                          null: false
    t.integer  "ordinal",                        limit: 4,                                          null: false
    t.integer  "selected_children",              limit: 4,                                          null: false
    t.integer  "randomized_children",            limit: 4,                                          null: false
    t.datetime "first_completion_timestamp_utc"
    t.integer  "prev_attempt_progress_status",   limit: 4,                             default: 0,  null: false
    t.integer  "prev_attempt_completion_status", limit: 4,                             default: 0,  null: false
    t.integer  "attempted_during_this_attempt",  limit: 4,                             default: 0,  null: false
    t.integer  "attempt_completion_amount_stat", limit: 4,                             default: 0,  null: false
    t.datetime "activity_start_timestamp_utc"
    t.datetime "attempt_start_timestamp_utc"
    t.integer  "activity_absolute_dur",          limit: 8,                             default: -1, null: false
    t.integer  "attempt_absolute_dur",           limit: 8,                             default: 0,  null: false
    t.integer  "activity_exp_dur_tracked",       limit: 8,                             default: 0,  null: false
    t.integer  "attempt_exp_dur_tracked",        limit: 8,                             default: 0,  null: false
    t.integer  "activity_exp_dur_reported",      limit: 8,                             default: 0,  null: false
    t.integer  "attempt_exp_dur_reported",       limit: 8,                             default: 0,  null: false
    t.string   "aicc_session_id",                limit: 2000
    t.integer  "is_latest_attempt",              limit: 4,                             default: 1,  null: false
  end

  add_index "scormactivity", ["scorm_object_id"], name: "FK_ScormActivity_ScormObject", using: :btree
  add_index "scormactivity", ["scorm_object_id"], name: "IX_SA_object_id", using: :btree
  add_index "scormactivity", ["scorm_registration_id"], name: "IX_ScormActivity", using: :btree

  create_table "scormactivityobjective", id: false, force: :cascade do |t|
    t.string   "update_by",                    limit: 32,                                          null: false
    t.datetime "update_dt",                                                                        null: false
    t.integer  "scorm_activity_id",            limit: 4,                                           null: false
    t.integer  "scorm_activity_objective_id",  limit: 4,                                           null: false
    t.string   "objective_identifier",         limit: 4000
    t.integer  "objective_progress_status",    limit: 4,                                           null: false
    t.integer  "objective_satisfied_status",   limit: 4,                                           null: false
    t.integer  "objective_measure_status",     limit: 4,                                           null: false
    t.decimal  "objective_normalized_measure",              precision: 10, scale: 7,               null: false
    t.integer  "primary_objective",            limit: 4,                                           null: false
    t.datetime "first_success_timestamp_utc"
    t.decimal  "first_obj_normalized_measure",              precision: 10, scale: 7, default: 0.0
    t.integer  "prev_obj_progress_status",     limit: 4,                             default: 0,   null: false
    t.integer  "prev_obj_satisfied_status",    limit: 4,                             default: 0,   null: false
    t.integer  "prev_obj_measure_status",      limit: 4,                             default: 0,   null: false
    t.decimal  "prev_obj_normalized_measure",               precision: 10, scale: 7, default: 0.0, null: false
    t.integer  "completion_status",            limit: 4,                             default: 0,   null: false
    t.integer  "completion_status_value",      limit: 4,                             default: 0,   null: false
    t.decimal  "score_raw",                                 precision: 38, scale: 7
    t.decimal  "score_max",                                 precision: 38, scale: 7
    t.decimal  "score_min",                                 precision: 38, scale: 7
    t.integer  "progress_measure_status",      limit: 4,                             default: 0,   null: false
    t.decimal  "progress_measure",                          precision: 10, scale: 7
  end

  create_table "scormactivityrt", primary_key: "scorm_activity_id", force: :cascade do |t|
    t.string   "update_by",                  limit: 32,                                              null: false
    t.datetime "update_dt",                                                                          null: false
    t.integer  "completion_status",          limit: 4,                                               null: false
    t.integer  "credit",                     limit: 4,                                               null: false
    t.integer  "entry",                      limit: 4,                                               null: false
    t.integer  "exit_mode",                  limit: 4,                                               null: false
    t.text     "location",                   limit: 4294967295
    t.integer  "location_null",              limit: 4,                                   default: 1, null: false
    t.integer  "lesson_mode",                limit: 4,                                               null: false
    t.decimal  "progress_measure",                              precision: 10, scale: 7
    t.decimal  "score_raw",                                     precision: 38, scale: 7
    t.decimal  "score_max",                                     precision: 38, scale: 7
    t.decimal  "score_min",                                     precision: 38, scale: 7
    t.decimal  "score_scaled",                                  precision: 10, scale: 7
    t.integer  "success_status",             limit: 4,                                               null: false
    t.text     "suspend_data",               limit: 4294967295
    t.integer  "suspend_data_null",          limit: 4,                                   default: 1, null: false
    t.text     "suspend_data_overflow",      limit: 4294967295
    t.integer  "suspend_data_overflow_null", limit: 4,                                   default: 1, null: false
    t.integer  "total_time",                 limit: 8,                                               null: false
    t.integer  "total_time_tracked",         limit: 8,                                               null: false
    t.decimal  "audio_level",                                   precision: 38, scale: 7,             null: false
    t.string   "language_preference",        limit: 255
    t.decimal  "delivery_speed",                                precision: 38, scale: 7,             null: false
    t.integer  "audio_captioning",           limit: 4,                                               null: false
  end

  create_table "scormactivityrtcomment", id: false, force: :cascade do |t|
    t.string   "update_by",         limit: 32,                     null: false
    t.datetime "update_dt",                                        null: false
    t.integer  "scorm_activity_id", limit: 4,                      null: false
    t.integer  "comment_index",     limit: 4,                      null: false
    t.integer  "from_lms",          limit: 4,                      null: false
    t.text     "comment_text",      limit: 4294967295
    t.integer  "comment_text_null", limit: 4,          default: 1, null: false
    t.string   "language",          limit: 260
    t.integer  "language_null",     limit: 4,          default: 1, null: false
    t.string   "location",          limit: 250
    t.integer  "location_null",     limit: 4,          default: 1, null: false
    t.datetime "timestamp_utc"
    t.string   "timestamp_text",    limit: 30
    t.integer  "timestamp_null",    limit: 4,          default: 1, null: false
    t.string   "id",                limit: 200
  end

  create_table "scormactivityrtintcorrectresp", id: false, force: :cascade do |t|
    t.string   "update_by",                      limit: 32,         null: false
    t.datetime "update_dt",                                         null: false
    t.integer  "scorm_activity_id",              limit: 4,          null: false
    t.integer  "interaction_index",              limit: 4,          null: false
    t.integer  "interaction_correct_resp_index", limit: 4,          null: false
    t.text     "correct_response",               limit: 4294967295
    t.text     "correct_response_overflow",      limit: 4294967295
  end

  create_table "scormactivityrtinteraction", id: false, force: :cascade do |t|
    t.string   "update_by",         limit: 32,                                        null: false
    t.datetime "update_dt",                                                           null: false
    t.integer  "scorm_activity_id", limit: 4,                                         null: false
    t.integer  "interaction_index", limit: 4,                                         null: false
    t.string   "interaction_id",    limit: 4000
    t.integer  "type",              limit: 4
    t.datetime "timestamp_utc"
    t.string   "timestamp_text",    limit: 30
    t.integer  "timestamp_null",    limit: 4,                             default: 1, null: false
    t.decimal  "weighting",                      precision: 10, scale: 7
    t.integer  "result",            limit: 4
    t.decimal  "result_numeric",                 precision: 10, scale: 7
    t.integer  "latency",           limit: 8
    t.string   "description",       limit: 510
    t.integer  "description_null",  limit: 4,                             default: 1, null: false
  end

  create_table "scormactivityrtintlearnerresp", id: false, force: :cascade do |t|
    t.string   "update_by",                      limit: 32,                     null: false
    t.datetime "update_dt",                                                     null: false
    t.integer  "scorm_activity_id",              limit: 4,                      null: false
    t.integer  "interaction_index",              limit: 4,                      null: false
    t.text     "learner_response",               limit: 4294967295
    t.integer  "learner_response_null",          limit: 4,          default: 1, null: false
    t.text     "learner_response_overflow",      limit: 4294967295
    t.integer  "learner_response_overflow_null", limit: 4,          default: 1, null: false
  end

  create_table "scormactivityrtintobjective", id: false, force: :cascade do |t|
    t.string   "update_by",                   limit: 32,   null: false
    t.datetime "update_dt",                                null: false
    t.integer  "scorm_activity_id",           limit: 4,    null: false
    t.integer  "interaction_index",           limit: 4,    null: false
    t.integer  "interaction_objective_index", limit: 4,    null: false
    t.string   "objective_id",                limit: 4000
  end

  create_table "scormactivityrtobjective", id: false, force: :cascade do |t|
    t.string   "update_by",         limit: 32,                                        null: false
    t.datetime "update_dt",                                                           null: false
    t.integer  "scorm_activity_id", limit: 4,                                         null: false
    t.integer  "objective_index",   limit: 4,                                         null: false
    t.string   "objective_id",      limit: 4000
    t.integer  "objective_id_null", limit: 4,                             default: 1, null: false
    t.integer  "success_status",    limit: 4,                                         null: false
    t.integer  "completion_status", limit: 4,                                         null: false
    t.decimal  "score_scaled",                   precision: 10, scale: 7
    t.decimal  "score_raw",                      precision: 38, scale: 7
    t.decimal  "score_max",                      precision: 38, scale: 7
    t.decimal  "score_min",                      precision: 38, scale: 7
    t.decimal  "progress_measure",               precision: 10, scale: 7
    t.string   "description",       limit: 510
    t.integer  "description_null",  limit: 4,                             default: 1, null: false
  end

  create_table "scormaiccsession", primary_key: "aicc_session_id", force: :cascade do |t|
    t.string   "update_by",                limit: 32,   null: false
    t.datetime "update_dt",                             null: false
    t.string   "legacy_aicc_session_id",   limit: 2000
    t.integer  "scorm_registration_id",    limit: 4,    null: false
    t.string   "external_registration_id", limit: 2000, null: false
    t.string   "external_configuration",   limit: 2000
    t.integer  "is_tracking",              limit: 4,    null: false
    t.integer  "launch_history_id",        limit: 4
  end

  add_index "scormaiccsession", ["scorm_registration_id"], name: "IX_ScormAiccSession", using: :btree

  create_table "scormenginedbupdates", primary_key: "update_id", force: :cascade do |t|
    t.string   "update_by", limit: 32, null: false
    t.datetime "update_dt",            null: false
  end

  create_table "scormexpirableobjectstore", force: :cascade do |t|
    t.string   "update_by", limit: 32,         null: false
    t.datetime "update_dt",                    null: false
    t.text     "value",     limit: 4294967295, null: false
    t.datetime "expiry"
  end

  create_table "scormlaunchhistory", primary_key: "launch_history_id", force: :cascade do |t|
    t.string   "update_by",                    limit: 32,                                  null: false
    t.datetime "update_dt",                                                                null: false
    t.integer  "scorm_registration_id",        limit: 4,                                   null: false
    t.datetime "launch_time",                                                              null: false
    t.datetime "exit_time"
    t.string   "completion",                   limit: 20
    t.string   "satisfaction",                 limit: 20
    t.integer  "measure_status",               limit: 4
    t.decimal  "normalized_measure",                              precision: 10, scale: 7
    t.integer  "experienced_duration_tracked", limit: 8
    t.text     "history_log",                  limit: 4294967295
    t.datetime "last_runtime_update"
    t.datetime "launch_time_utc"
    t.datetime "exit_time_utc"
    t.datetime "update_dt_utc"
    t.datetime "last_runtime_update_utc"
  end

  add_index "scormlaunchhistory", ["scorm_registration_id", "launch_time"], name: "IX_ScormLaunchHistory", using: :btree
  add_index "scormlaunchhistory", ["update_dt"], name: "IX_ScormLaunchHistory_update", using: :btree

  create_table "scormmetadata", primary_key: "scorm_metadata_id", force: :cascade do |t|
    t.string   "update_by",             limit: 32,         null: false
    t.datetime "update_dt",                                null: false
    t.integer  "scorm_package_id",      limit: 4,          null: false
    t.integer  "scorm_object_id",       limit: 4
    t.integer  "metadata_index",        limit: 4,          null: false
    t.text     "metadata_xml",          limit: 4294967295
    t.string   "identifier",            limit: 1000
    t.string   "title",                 limit: 1000
    t.text     "description",           limit: 4294967295
    t.text     "keywords",              limit: 4294967295
    t.string   "language_code",         limit: 100
    t.string   "version",               limit: 50
    t.string   "duration",              limit: 20
    t.string   "typical_learning_time", limit: 20
    t.string   "file_href",             limit: 1000
  end

  add_index "scormmetadata", ["scorm_object_id"], name: "FK_ScormMetadata_ScormObject", using: :btree
  add_index "scormmetadata", ["scorm_object_id"], name: "IX_SMD_object_id", using: :btree
  add_index "scormmetadata", ["scorm_package_id"], name: "FK_ScormMetadata_ScormPackage", using: :btree
  add_index "scormmetadata", ["scorm_package_id"], name: "IX_SMD_package_id", using: :btree

  create_table "scormobject", primary_key: "scorm_object_id", force: :cascade do |t|
    t.string   "update_by",                  limit: 32,                                                null: false
    t.datetime "update_dt",                                                                            null: false
    t.integer  "scorm_package_id",           limit: 4,                                                 null: false
    t.integer  "scorm_object_type_id",       limit: 4,                                                 null: false
    t.string   "title",                      limit: 200
    t.string   "href",                       limit: 2000
    t.string   "parameters",                 limit: 1000
    t.text     "data_from_lms",              limit: 4294967295
    t.decimal  "mastery_score",                                 precision: 10, scale: 7
    t.integer  "max_time_allowed",           limit: 8
    t.integer  "time_limit_action",          limit: 4
    t.string   "prerequisites",              limit: 200
    t.integer  "visible",                    limit: 4,                                                 null: false
    t.decimal  "completion_threshold",                          precision: 10, scale: 7
    t.integer  "persist_state",              limit: 4,                                                 null: false
    t.text     "file_list",                  limit: 4294967295
    t.integer  "completed_by_measure",       limit: 4,                                   default: 0,   null: false
    t.decimal  "completion_progress_weight",                    precision: 10, scale: 7, default: 1.0, null: false
    t.string   "letsi_rtws_secret",          limit: 1000
  end

  add_index "scormobject", ["scorm_package_id"], name: "FK_ScormObject_ScormPackage", using: :btree
  add_index "scormobject", ["scorm_package_id"], name: "IX_SO_package_id", using: :btree

  create_table "scormobjecthierarchy", id: false, force: :cascade do |t|
    t.string   "update_by",              limit: 32, null: false
    t.datetime "update_dt",                         null: false
    t.integer  "parent_scorm_object_id", limit: 4,  null: false
    t.integer  "child_scorm_object_id",  limit: 4,  null: false
    t.integer  "ordinal",                limit: 4,  null: false
  end

  add_index "scormobjecthierarchy", ["child_scorm_object_id"], name: "FK_ScormObjectHierarchyChil_1", using: :btree
  add_index "scormobjecthierarchy", ["child_scorm_object_id"], name: "IX_SOH_child_object_id", using: :btree

  create_table "scormobjectidentifiers", primary_key: "scorm_object_id", force: :cascade do |t|
    t.string   "update_by",           limit: 32,         null: false
    t.datetime "update_dt",                              null: false
    t.string   "item_identifier",     limit: 4000
    t.string   "resource_identifier", limit: 2000
    t.text     "external_identifier", limit: 4294967295
  end

  create_table "scormobjectseqdata", primary_key: "scorm_object_id", force: :cascade do |t|
    t.string   "update_by",                      limit: 32,                                     null: false
    t.datetime "update_dt",                                                                     null: false
    t.integer  "hide_previous",                  limit: 4,                                      null: false
    t.integer  "hide_continue",                  limit: 4,                                      null: false
    t.integer  "hide_exit",                      limit: 4,                                      null: false
    t.integer  "hide_abandon",                   limit: 4,                                      null: false
    t.integer  "control_choice",                 limit: 4,                                      null: false
    t.integer  "control_choice_exit",            limit: 4,                                      null: false
    t.integer  "control_flow",                   limit: 4,                                      null: false
    t.integer  "control_forward_only",           limit: 4,                                      null: false
    t.integer  "use_current_attempt_obj_info",   limit: 4,                                      null: false
    t.integer  "use_current_attempt_prog_info",  limit: 4,                                      null: false
    t.integer  "constrain_choice",               limit: 4,                                      null: false
    t.integer  "prevent_activation",             limit: 4,                                      null: false
    t.integer  "limit_cond_attempt_control",     limit: 4,                                      null: false
    t.integer  "limit_cond_attempt_limit",       limit: 4,                                      null: false
    t.integer  "limit_cond_attempt_dur_control", limit: 4,                                      null: false
    t.string   "limit_cond_attempt_dur_limit",   limit: 50
    t.integer  "rollup_objective_satisfied",     limit: 4,                                      null: false
    t.decimal  "rollup_obj_measure_weight",                 precision: 5, scale: 4,             null: false
    t.integer  "rollup_progress_completion",     limit: 4,                                      null: false
    t.integer  "measure_satisfaction_if_active", limit: 4,                                      null: false
    t.integer  "required_for_satisfied",         limit: 4,                                      null: false
    t.integer  "required_for_not_satisfied",     limit: 4,                                      null: false
    t.integer  "required_for_completed",         limit: 4,                                      null: false
    t.integer  "required_for_incomplete",        limit: 4,                                      null: false
    t.integer  "selection_timing",               limit: 4,                                      null: false
    t.integer  "selection_count_status",         limit: 4,                                      null: false
    t.integer  "selection_count",                limit: 4,                                      null: false
    t.integer  "randomization_timing",           limit: 4,                                      null: false
    t.integer  "randomize_children",             limit: 4,                                      null: false
    t.integer  "tracked",                        limit: 4,                                      null: false
    t.integer  "completion_set_by_content",      limit: 4,                                      null: false
    t.integer  "objective_set_by_content",       limit: 4,                                      null: false
    t.integer  "hide_suspend_all",               limit: 4,                          default: 0, null: false
    t.integer  "hide_abandon_all",               limit: 4,                          default: 0, null: false
    t.integer  "hide_exit_all",                  limit: 4,                          default: 0, null: false
  end

  create_table "scormobjectseqobjective", id: false, force: :cascade do |t|
    t.string   "update_by",                     limit: 32,                           null: false
    t.datetime "update_dt",                                                          null: false
    t.integer  "scorm_object_id",               limit: 4,                            null: false
    t.integer  "scorm_object_seq_objective_id", limit: 4,                            null: false
    t.string   "objective_identifier",          limit: 4000
    t.integer  "satisfied_by_measure",          limit: 4,                            null: false
    t.decimal  "min_normalized_measure",                     precision: 5, scale: 4, null: false
    t.integer  "primary_objective",             limit: 4,                            null: false
  end

  create_table "scormobjectseqobjectivemap", id: false, force: :cascade do |t|
    t.string   "update_by",                     limit: 32,               null: false
    t.datetime "update_dt",                                              null: false
    t.integer  "scorm_object_id",               limit: 4,                null: false
    t.integer  "scorm_object_seq_objective_id", limit: 4,                null: false
    t.integer  "scorm_object_seq_obj_map_id",   limit: 4,                null: false
    t.string   "target_objective_id",           limit: 4000
    t.integer  "read_satisfied_status",         limit: 4,                null: false
    t.integer  "read_normalized_measure",       limit: 4,                null: false
    t.integer  "write_satisfied_status",        limit: 4,                null: false
    t.integer  "write_normalized_measure",      limit: 4,                null: false
    t.integer  "read_score_raw",                limit: 4,    default: 0, null: false
    t.integer  "read_score_min",                limit: 4,    default: 0, null: false
    t.integer  "read_score_max",                limit: 4,    default: 0, null: false
    t.integer  "read_completion_status",        limit: 4,    default: 0, null: false
    t.integer  "read_progress_measure",         limit: 4,    default: 0, null: false
    t.integer  "write_score_raw",               limit: 4,    default: 0, null: false
    t.integer  "write_score_min",               limit: 4,    default: 0, null: false
    t.integer  "write_score_max",               limit: 4,    default: 0, null: false
    t.integer  "write_completion_status",       limit: 4,    default: 0, null: false
    t.integer  "write_progress_measure",        limit: 4,    default: 0, null: false
  end

  create_table "scormobjectseqrolluprule", id: false, force: :cascade do |t|
    t.string   "update_by",             limit: 32,                         null: false
    t.datetime "update_dt",                                                null: false
    t.integer  "scorm_object_id",       limit: 4,                          null: false
    t.integer  "rollup_rule_id",        limit: 4,                          null: false
    t.integer  "condition_combination", limit: 4,                          null: false
    t.integer  "child_activity_set",    limit: 4,                          null: false
    t.integer  "minimum_count",         limit: 4,                          null: false
    t.decimal  "minimum_percent",                  precision: 5, scale: 4, null: false
    t.integer  "action",                limit: 4,                          null: false
  end

  create_table "scormobjectseqrolluprulecond", id: false, force: :cascade do |t|
    t.string   "update_by",                limit: 32, null: false
    t.datetime "update_dt",                           null: false
    t.integer  "scorm_object_id",          limit: 4,  null: false
    t.integer  "rollup_rule_id",           limit: 4,  null: false
    t.integer  "rollup_rule_condition_id", limit: 4,  null: false
    t.integer  "condition_operator",       limit: 4,  null: false
    t.integer  "rule_condition",           limit: 4,  null: false
  end

  create_table "scormobjectseqrule", id: false, force: :cascade do |t|
    t.string   "update_by",             limit: 32, null: false
    t.datetime "update_dt",                        null: false
    t.integer  "scorm_object_id",       limit: 4,  null: false
    t.integer  "seq_rule_id",           limit: 4,  null: false
    t.integer  "condition_combination", limit: 4,  null: false
    t.integer  "action",                limit: 4,  null: false
    t.integer  "rule_type",             limit: 4,  null: false
  end

  create_table "scormobjectseqrulecond", id: false, force: :cascade do |t|
    t.string   "update_by",             limit: 32,                           null: false
    t.datetime "update_dt",                                                  null: false
    t.integer  "scorm_object_id",       limit: 4,                            null: false
    t.integer  "seq_rule_id",           limit: 4,                            null: false
    t.integer  "seq_rule_condition_id", limit: 4,                            null: false
    t.integer  "rule_condition",        limit: 4,                            null: false
    t.string   "referenced_objective",  limit: 4000
    t.decimal  "measure_threshold",                  precision: 5, scale: 4, null: false
    t.integer  "condition_operator",    limit: 4,                            null: false
  end

  create_table "scormobjectshareddatamap", id: false, force: :cascade do |t|
    t.string   "update_by",                    limit: 32,   null: false
    t.datetime "update_dt",                                 null: false
    t.integer  "scorm_object_id",              limit: 4,    null: false
    t.integer  "scorm_obj_shared_data_map_id", limit: 4,    null: false
    t.string   "target_shared_data_id",        limit: 4000, null: false
    t.integer  "read_shared_data",             limit: 4,    null: false
    t.integer  "write_shared_data",            limit: 4,    null: false
  end

  create_table "scormobjectsspbucket", id: false, force: :cascade do |t|
    t.string   "update_by",         limit: 32,               null: false
    t.datetime "update_dt",                                  null: false
    t.integer  "scorm_object_id",   limit: 4,                null: false
    t.integer  "bucket_index",      limit: 4,                null: false
    t.string   "bucket_identifier", limit: 4000,             null: false
    t.string   "bucket_type",       limit: 3000
    t.integer  "persistence",       limit: 4,                null: false
    t.integer  "size_min",          limit: 8,                null: false
    t.integer  "size_requested",    limit: 8,                null: false
    t.integer  "reducible",         limit: 4,    default: 0, null: false
  end

  create_table "scormobjectstore", primary_key: "object_key_sha1", force: :cascade do |t|
    t.string   "update_by",    limit: 32,    null: false
    t.datetime "update_dt",                  null: false
    t.string   "object_key",   limit: 255,   null: false
    t.binary   "object_value", limit: 65535, null: false
    t.string   "object_type",  limit: 64,    null: false
    t.datetime "expiry"
  end

  add_index "scormobjectstore", ["expiry"], name: "IX_SOS_e", using: :btree

  create_table "scormpackage", primary_key: "scorm_package_id", force: :cascade do |t|
    t.string   "update_by",                    limit: 32,                null: false
    t.datetime "update_dt",                                              null: false
    t.integer  "objectives_global_to_system",  limit: 4,                 null: false
    t.integer  "learning_standard_id",         limit: 4,                 null: false
    t.string   "web_path",                     limit: 500, default: "'"
    t.integer  "version_id",                   limit: 4,   default: 0,   null: false
    t.integer  "shared_data_global_to_system", limit: 4,   default: 1,   null: false
    t.integer  "program_id",                   limit: 4,                 null: false
    t.string   "display_title",                limit: 200
    t.string   "invariant_title",              limit: 200
  end

  add_index "scormpackage", ["invariant_title"], name: "IX_SP_invariant_title", using: :btree
  add_index "scormpackage", ["program_id", "version_id"], name: "ScormPackageExternalId", unique: true, using: :btree
  add_index "scormpackage", ["update_dt", "scorm_package_id"], name: "IX_SP_console_ordering", using: :btree
  add_index "scormpackage", ["update_dt", "scorm_package_id"], name: "ScormPackage_updpk", using: :btree

  create_table "scormpackageproperties", primary_key: "scorm_package_id", force: :cascade do |t|
    t.string   "update_by",                      limit: 32,                                          null: false
    t.datetime "update_dt",                                                                          null: false
    t.integer  "show_finish_button",             limit: 4,                                           null: false
    t.integer  "show_course_structure",          limit: 4,                                           null: false
    t.integer  "show_progress_bar",              limit: 4,                                           null: false
    t.integer  "show_help",                      limit: 4,                                           null: false
    t.integer  "show_nav_bar",                   limit: 4,                                           null: false
    t.integer  "show_titlebar",                  limit: 4,                                           null: false
    t.integer  "enable_flow_nav",                limit: 4,                                           null: false
    t.integer  "enable_choice_nav",              limit: 4,                                           null: false
    t.integer  "course_structure_width",         limit: 4,                                           null: false
    t.integer  "course_structure_starts_open",   limit: 4,                                           null: false
    t.integer  "sco_launch_type",                limit: 4,                                           null: false
    t.integer  "player_launch_type",             limit: 4,                                           null: false
    t.integer  "prevent_right_click",            limit: 4,                                           null: false
    t.integer  "prevent_window_resize",          limit: 4,                                           null: false
    t.integer  "required_width",                 limit: 4,                                           null: false
    t.integer  "required_height",                limit: 4,                                           null: false
    t.integer  "required_fullscreen",            limit: 4,                                           null: false
    t.integer  "desired_width",                  limit: 4,                                           null: false
    t.integer  "desired_height",                 limit: 4,                                           null: false
    t.integer  "desired_fullscreen",             limit: 4,                                           null: false
    t.integer  "int_sat_logout_action",          limit: 4,                                           null: false
    t.integer  "int_sat_normal_action",          limit: 4,                                           null: false
    t.integer  "int_sat_suspend_action",         limit: 4,                                           null: false
    t.integer  "int_sat_timeout_action",         limit: 4,                                           null: false
    t.integer  "int_not_sat_logout_action",      limit: 4,                                           null: false
    t.integer  "int_not_sat_normal_action",      limit: 4,                                           null: false
    t.integer  "int_not_sat_suspend_action",     limit: 4,                                           null: false
    t.integer  "int_not_sat_timeout_action",     limit: 4,                                           null: false
    t.integer  "final_sat_logout_action",        limit: 4,                                           null: false
    t.integer  "final_sat_normal_action",        limit: 4,                                           null: false
    t.integer  "final_sat_suspend_action",       limit: 4,                                           null: false
    t.integer  "final_sat_timeout_action",       limit: 4,                                           null: false
    t.integer  "final_not_sat_logout_action",    limit: 4,                                           null: false
    t.integer  "final_not_sat_normal_action",    limit: 4,                                           null: false
    t.integer  "final_not_sat_suspend_action",   limit: 4,                                           null: false
    t.integer  "final_not_sat_timeout_action",   limit: 4,                                           null: false
    t.integer  "status_display",                 limit: 4,                                           null: false
    t.integer  "score_rollup_mode",              limit: 4,                                           null: false
    t.integer  "number_of_scoring_objects",      limit: 4
    t.integer  "status_rollup_mode",             limit: 4,                                           null: false
    t.decimal  "threshold_score_for_completion",            precision: 10, scale: 7
    t.integer  "first_sco_is_pretest",           limit: 4,                                           null: false
    t.integer  "wrap_sco_window_with_api",       limit: 4,                                           null: false
    t.integer  "finish_causes_immediate_commit", limit: 4,                                           null: false
    t.integer  "debug_control_audit",            limit: 4,                                           null: false
    t.integer  "debug_control_detailed",         limit: 4,                                           null: false
    t.integer  "debug_rte_audit",                limit: 4,                                           null: false
    t.integer  "debug_rte_detailed",             limit: 4,                                           null: false
    t.integer  "debug_sequencing_audit",         limit: 4,                                           null: false
    t.integer  "debug_sequencing_detailed",      limit: 4,                                           null: false
    t.integer  "debug_lookahead_audit",          limit: 4,                                           null: false
    t.integer  "debug_lookahead_detailed",       limit: 4,                                           null: false
    t.integer  "debug_include_timestamps",       limit: 4,                                           null: false
    t.integer  "comm_max_failed_submissions",    limit: 4,                                           null: false
    t.integer  "comm_commit_frequency",          limit: 4,                                           null: false
    t.integer  "invalid_menu_item_action",       limit: 4,                           default: 2,     null: false
    t.integer  "always_flow_to_first_sco",       limit: 4,                                           null: false
    t.integer  "logout_causes_player_exit",      limit: 4,                                           null: false
    t.integer  "reset_rt_timing",                limit: 4,                                           null: false
    t.integer  "offline_synch_mode",             limit: 4,                           default: 1,     null: false
    t.integer  "validate_interaction_responses", limit: 4,                           default: 1,     null: false
    t.integer  "lookahead_sequencer_mode",       limit: 4,                           default: 2,     null: false
    t.integer  "show_close_item",                limit: 4,                           default: 0,     null: false
    t.integer  "score_overrides_status",         limit: 4,                           default: 0,     null: false
    t.integer  "scale_raw_score",                limit: 4,                           default: 0,     null: false
    t.integer  "rollup_empty_set_to_unknown",    limit: 4,                           default: 0,     null: false
    t.integer  "capture_history",                limit: 4,                           default: 0,     null: false
    t.integer  "capture_history_detailed",       limit: 4,                           default: 0,     null: false
    t.integer  "return_to_lms_action",           limit: 4,                           default: 1,     null: false
    t.integer  "use_measure_progress_bar",       limit: 4,                           default: 0,     null: false
    t.integer  "use_quick_lookahead_seq",        limit: 4,                           default: 1,     null: false
    t.integer  "force_disable_root_choice",      limit: 4,                           default: 0,     null: false
    t.integer  "rollup_runtime_at_sco_unload",   limit: 4,                           default: 0,     null: false
    t.integer  "force_obj_compl_set_by_content", limit: 4,                           default: 0,     null: false
    t.integer  "invoke_rollup_at_suspendall",    limit: 4,                           default: 0,     null: false
    t.integer  "compl_stat_of_failed_suc_stat",  limit: 4,                           default: 1,     null: false
    t.integer  "satisfied_causes_completion",    limit: 4,                           default: 0,     null: false
    t.integer  "student_prefs_global_to_course", limit: 4,                           default: 0,     null: false
    t.integer  "debug_sequencing_simple",        limit: 4,                           default: 0,     null: false
    t.integer  "suspend_data_max_length",        limit: 4,                           default: 64000, null: false
    t.integer  "allow_complete_status_change",   limit: 4,                           default: 0,     null: false
    t.integer  "time_limit",                     limit: 4,                           default: 0,     null: false
    t.integer  "launch_compl_regs_as_no_credit", limit: 4,                           default: 1,     null: false
    t.integer  "apply_status_to_success",        limit: 4,                           default: 0,     null: false
    t.integer  "ie_compatibility_mode",          limit: 4,                           default: 4,     null: false
    t.integer  "is_available_offline",           limit: 4,                           default: 0,     null: false
  end

  create_table "scormpackagepropertiespresets", primary_key: "preset_id", force: :cascade do |t|
    t.string   "update_by",    limit: 32,         null: false
    t.datetime "update_dt",                       null: false
    t.string   "title",        limit: 100,        null: false
    t.string   "created_by",   limit: 50
    t.text     "property_xml", limit: 4294967295, null: false
  end

  create_table "scormregistration", primary_key: "scorm_registration_id", force: :cascade do |t|
    t.string   "update_by",              limit: 32,                null: false
    t.datetime "update_dt",                                        null: false
    t.integer  "scorm_package_id",       limit: 4,                 null: false
    t.string   "global_objective_scope", limit: 100, default: "'"
    t.integer  "suspended_activity_id",  limit: 4
    t.integer  "instance_id",            limit: 4,   default: 0,   null: false
    t.integer  "converted_to_tincan",    limit: 4,   default: 0,   null: false
    t.integer  "enrollment_id",          limit: 4,                 null: false
    t.datetime "update_dt_utc"
  end

  add_index "scormregistration", ["enrollment_id", "instance_id"], name: "ScormRegistrationExternalId", unique: true, using: :btree
  add_index "scormregistration", ["global_objective_scope"], name: "IX_SR_gos", using: :btree
  add_index "scormregistration", ["scorm_package_id"], name: "FK_ScormRegistration_ScormP_1", using: :btree
  add_index "scormregistration", ["scorm_package_id"], name: "IX_SR_package_id", using: :btree
  add_index "scormregistration", ["suspended_activity_id"], name: "FK_ScormRegistration_ScormA_1", using: :btree
  add_index "scormregistration", ["suspended_activity_id"], name: "IX_SR_suspended_activity_id", using: :btree
  add_index "scormregistration", ["update_dt_utc"], name: "IX_SR_update_dt_utc", using: :btree

  create_table "scormregistrationglobalobj", id: false, force: :cascade do |t|
    t.string   "update_by",                    limit: 32,                                        null: false
    t.datetime "update_dt",                                                                      null: false
    t.integer  "scorm_registration_id",        limit: 4,                                         null: false
    t.integer  "scorm_registration_obj_id",    limit: 4,                                         null: false
    t.string   "objective_identifier",         limit: 4000
    t.integer  "objective_progress_status",    limit: 4,                                         null: false
    t.integer  "objective_satisfied_status",   limit: 4,                                         null: false
    t.integer  "objective_measure_status",     limit: 4,                                         null: false
    t.decimal  "objective_normalized_measure",              precision: 5,  scale: 4,             null: false
    t.integer  "completion_status",            limit: 4,                             default: 0, null: false
    t.integer  "completion_status_value",      limit: 4,                             default: 0, null: false
    t.decimal  "score_raw",                                 precision: 38, scale: 7
    t.decimal  "score_max",                                 precision: 38, scale: 7
    t.decimal  "score_min",                                 precision: 38, scale: 7
    t.integer  "progress_measure_status",      limit: 4,                             default: 0, null: false
    t.decimal  "progress_measure",                          precision: 10, scale: 7
  end

  create_table "scormregistrationshareddata", id: false, force: :cascade do |t|
    t.string   "update_by",                  limit: 32,   null: false
    t.datetime "update_dt",                               null: false
    t.integer  "scorm_registration_id",      limit: 4,    null: false
    t.integer  "scorm_registration_data_id", limit: 4,    null: false
    t.string   "shared_data_id",             limit: 4000, null: false
    t.integer  "scorm_shared_data_value_id", limit: 4,    null: false
  end

  add_index "scormregistrationshareddata", ["scorm_shared_data_value_id"], name: "FK_ScormRegistrationSharedD_2", using: :btree
  add_index "scormregistrationshareddata", ["scorm_shared_data_value_id"], name: "IX_SRS_data_value_id", using: :btree

  create_table "scormregistrationshareddataval", primary_key: "scorm_shared_data_value_id", force: :cascade do |t|
    t.string   "update_by",              limit: 32,         null: false
    t.datetime "update_dt",                                 null: false
    t.text     "data",                   limit: 4294967295
    t.integer  "scorm_registration_id",  limit: 4
    t.string   "global_objective_scope", limit: 100
    t.string   "shared_data_id",         limit: 400,        null: false
  end

  add_index "scormregistrationshareddataval", ["scorm_registration_id"], name: "IX_SRSV_registration_id", using: :btree

  create_table "scormregistrationsspbucket", id: false, force: :cascade do |t|
    t.string   "update_by",             limit: 32,         null: false
    t.datetime "update_dt",                                null: false
    t.integer  "scorm_registration_id", limit: 4,          null: false
    t.integer  "bucket_index",          limit: 4,          null: false
    t.string   "bucket_identifier",     limit: 4000,       null: false
    t.string   "bucket_type",           limit: 3000
    t.integer  "persistence",           limit: 4,          null: false
    t.integer  "size_min",              limit: 8,          null: false
    t.integer  "size_requested",        limit: 8,          null: false
    t.integer  "reducible",             limit: 4,          null: false
    t.string   "local_activity_id",     limit: 50
    t.integer  "allocation_success",    limit: 4,          null: false
    t.text     "data",                  limit: 4294967295
  end

  create_table "searchablepage", primary_key: "Page_ID", force: :cascade, options: 'ENGINE=MyISAM' do |t|
    t.text "SearchableText", limit: 65535, null: false
  end

  add_index "searchablepage", ["SearchableText"], name: "SearchableText", type: :fulltext

  create_table "specialty", primary_key: "ID", force: :cascade do |t|
    t.integer "TrainingField_ID", limit: 1,  null: false
    t.string  "Name",             limit: 64, null: false
  end

  add_index "specialty", ["TrainingField_ID", "Name"], name: "UIDX_Specialty_TrainingField_ID_Name", unique: true, using: :btree

  create_table "stage", primary_key: "ID", force: :cascade do |t|
    t.string  "Name",               limit: 64,                       null: false
    t.string  "Description",        limit: 128,                      null: false
    t.text    "Instructions",       limit: 16777215,                 null: false
    t.boolean "RandomizeQuestions",                  default: false, null: false
  end

  create_table "stageaccess", id: false, force: :cascade do |t|
    t.integer "Stage_ID",            limit: 4, null: false
    t.integer "AssessmentRecord_ID", limit: 4, null: false
    t.integer "AccessType",          limit: 1, null: false
  end

  add_index "stageaccess", ["Stage_ID"], name: "Stage_ID", using: :btree

  create_table "stagecontents", id: false, force: :cascade do |t|
    t.integer "Stage_ID",          limit: 4, null: false
    t.integer "SortOrder",         limit: 1, null: false
    t.integer "Group_ID",          limit: 4, null: false
    t.integer "QuestionsToSelect", limit: 2, null: false
  end

  add_index "stagecontents", ["Group_ID"], name: "Group_ID", using: :btree
  add_index "stagecontents", ["Stage_ID", "SortOrder", "Group_ID"], name: "StageContentsIdentifier", unique: true, using: :btree
  add_index "stagecontents", ["Stage_ID"], name: "Stage_ID", using: :btree

  create_table "state", primary_key: "ID", force: :cascade do |t|
    t.integer "Country_ID",   limit: 1,  null: false
    t.string  "Name",         limit: 64, null: false
    t.string  "Abbreviation", limit: 5,  null: false
  end

  add_index "state", ["Country_ID", "Name"], name: "IDX_State_Country_ID_Name", using: :btree

  create_table "statesalestax", primary_key: "State_ID", force: :cascade do |t|
    t.decimal "Rate", precision: 4, scale: 4, null: false
  end

  create_table "statuschangereason", primary_key: "ID", force: :cascade do |t|
    t.string  "Name",                          limit: 64,  null: false
    t.string  "Description",                   limit: 255, null: false
    t.boolean "ForDisabling"
    t.boolean "ForEnabling"
    t.boolean "ForCorrectingStartAndEndDates"
    t.boolean "ForPlacementDirect"
  end

  add_index "statuschangereason", ["Name"], name: "UIDX_StatusChangeReason_Name", unique: true, using: :btree

  create_table "student_message", primary_key: "Student_Message_ID", force: :cascade do |t|
    t.string   "Subject",         limit: 255
    t.text     "Message",         limit: 65535
    t.datetime "Create_DT",                     null: false
    t.integer  "Creator_User_ID", limit: 4,     null: false
  end

  add_index "student_message", ["Creator_User_ID"], name: "FK_User_StudentMessage", using: :btree

  create_table "systemannouncement", primary_key: "Announcement_ID", force: :cascade do |t|
  end

  create_table "tableinfo", primary_key: "TableName", force: :cascade do |t|
    t.integer "InsertionSortOrder", limit: 2
    t.string  "Type",               limit: 12,    null: false
    t.text    "Description",        limit: 65535
  end

  create_table "themeinfo", primary_key: "ID", force: :cascade do |t|
    t.string "Theme", limit: 32, null: false
    t.string "Title", limit: 64, null: false
  end

  create_table "threshold", primary_key: "ID", force: :cascade do |t|
    t.integer "Low",                   limit: 1, null: false
    t.integer "High",                  limit: 1, null: false
    t.integer "GradeName_ID",          limit: 1, null: false
    t.integer "GradeGraphic_ID",       limit: 1, null: false
    t.integer "GradeColor_ID",         limit: 1, null: false
    t.boolean "DisplayThresholdInKey",           null: false
    t.boolean "DisplayAnswers",                  null: false
  end

  add_index "threshold", ["GradeColor_ID"], name: "FK_Threshold_GradeColor_ID", using: :btree
  add_index "threshold", ["GradeGraphic_ID"], name: "FK_Threshold_GradeGraphic_ID", using: :btree
  add_index "threshold", ["GradeName_ID"], name: "FK_Threshold_GradeName_ID", using: :btree
  add_index "threshold", ["Low", "High"], name: "IDX_Threshold_Low_High", using: :btree

  create_table "thresholdcollection", primary_key: "ID", force: :cascade do |t|
    t.string "Name", limit: 32, null: false
  end

  create_table "thresholdcollectioncontents", id: false, force: :cascade do |t|
    t.integer "ThresholdCollection_ID", limit: 2, null: false
    t.integer "RecordingType_ID",       limit: 1, null: false
    t.integer "Activity_ID",            limit: 1, null: false
    t.integer "ThresholdSet_ID",        limit: 2, null: false
  end

  add_index "thresholdcollectioncontents", ["Activity_ID"], name: "FK_ThresholdCollectionContents_Activity_ID", using: :btree
  add_index "thresholdcollectioncontents", ["RecordingType_ID"], name: "FK_ThresholdCollectionContents_RecordingType_ID", using: :btree
  add_index "thresholdcollectioncontents", ["ThresholdSet_ID"], name: "FK_ThresholdCollectionContents_ThresholdSet_ID", using: :btree

  create_table "thresholdset", primary_key: "ID", force: :cascade do |t|
    t.string  "Name",         limit: 32, null: false
    t.integer "PassingScore", limit: 1,  null: false
  end

  create_table "thresholdsetcontents", id: false, force: :cascade do |t|
    t.integer "ThresholdSet_ID", limit: 2, null: false
    t.integer "Threshold_ID",    limit: 2, null: false
  end

  add_index "thresholdsetcontents", ["Threshold_ID"], name: "FK_ThresholdSetContents_Threshold_ID", using: :btree

  create_table "tincanactivityprovider", id: false, force: :cascade do |t|
    t.string   "update_by",   limit: 32,         default: "unknown", null: false
    t.datetime "update_dt",                                          null: false
    t.integer  "app_id",      limit: 4,                              null: false
    t.text     "info",        limit: 4294967295
    t.string   "name",        limit: 100
    t.string   "provider_id", limit: 100,                            null: false
    t.string   "public_key",  limit: 1000
    t.string   "secret",      limit: 100
  end

  add_index "tincanactivityprovider", ["provider_id"], name: "IX_TCAPIDX_provider", using: :btree

  create_table "tincanactivityprovidermap", id: false, force: :cascade do |t|
    t.string   "update_by",        limit: 32,   default: "unknown", null: false
    t.datetime "update_dt",                                         null: false
    t.integer  "app_id",           limit: 4,                        null: false
    t.string   "provider_id",      limit: 100,                      null: false
    t.binary   "activity_id_sha1", limit: 20,                       null: false
    t.string   "activity_id",      limit: 2048,                     null: false
  end

  create_table "tincanactorproperties", primary_key: "app_key_val_hash", force: :cascade do |t|
    t.string   "update_by", limit: 32,   default: "unknown", null: false
    t.datetime "update_dt",                                  null: false
    t.integer  "app_id",    limit: 4,                        null: false
    t.string   "key",       limit: 32,                       null: false
    t.string   "value",     limit: 1024,                     null: false
    t.string   "actor_id",  limit: 36,                       null: false
  end

  add_index "tincanactorproperties", ["actor_id"], name: "IX_ActorProp_ai", using: :btree
  add_index "tincanactorproperties", ["app_id", "actor_id", "key"], name: "IX_ActorProp_aakey", using: :btree

  create_table "tincanagent", id: false, force: :cascade do |t|
    t.string   "update_by",    limit: 32, default: "unknown", null: false
    t.datetime "update_dt",                                   null: false
    t.integer  "app_id",       limit: 4,                      null: false
    t.binary   "statement_id", limit: 16,                     null: false
    t.binary   "agent_id",     limit: 20,                     null: false
  end

  create_table "tincanappid", force: :cascade do |t|
    t.string   "update_by", limit: 32, default: "unknown", null: false
    t.datetime "update_dt",                                null: false
    t.string   "app_id",    limit: 64,                     null: false
  end

  add_index "tincanappid", ["app_id", "id"], name: "IX_TC_AppID", using: :btree

  create_table "tincancontenttoken", primary_key: "token_id", force: :cascade do |t|
    t.string   "update_by",              limit: 32,   default: "unknown", null: false
    t.datetime "update_dt",                                               null: false
    t.string   "external_id",            limit: 2000,                     null: false
    t.string   "external_configuration", limit: 2000
    t.datetime "expiry"
    t.integer  "preview_token",          limit: 4,    default: 0,         null: false
  end

  create_table "tincancontextactivity", id: false, force: :cascade do |t|
    t.string   "update_by",            limit: 32, default: "unknown", null: false
    t.datetime "update_dt",                                           null: false
    t.integer  "app_id",               limit: 4,                      null: false
    t.binary   "statement_id",         limit: 16,                     null: false
    t.binary   "ctx_activity_id_sha1", limit: 20,                     null: false
  end

  create_table "tincandocuments", primary_key: "document_id_hash", force: :cascade do |t|
    t.string   "update_by",         limit: 32,         default: "unknown", null: false
    t.datetime "update_dt",                                                null: false
    t.integer  "app_id",            limit: 4,                              null: false
    t.integer  "version",           limit: 4
    t.string   "registration_id",   limit: 36
    t.string   "actor_id",          limit: 40
    t.string   "activity_id",       limit: 1024
    t.string   "document_id",       limit: 255,                            null: false
    t.binary   "document_ctx_hash", limit: 20,                             null: false
    t.integer  "updated",           limit: 8,                              null: false
    t.integer  "content_length",    limit: 8,                              null: false
    t.string   "content_type",      limit: 64
    t.binary   "content_hash",      limit: 20,                             null: false
    t.string   "asserter_id",       limit: 82
    t.text     "asserter_json",     limit: 4294967295
  end

  add_index "tincandocuments", ["app_id"], name: "FK_TinCanDocuments_1", using: :btree

  create_table "tincanforwardingmap", force: :cascade do |t|
    t.string   "update_by",      limit: 32,   default: "unknown", null: false
    t.datetime "update_dt",                                       null: false
    t.string   "sourceUrl",      limit: 2000,                     null: false
    t.string   "sourceUsername", limit: 2000,                     null: false
    t.string   "sourcePW",       limit: 2000,                     null: false
    t.string   "targetUrl",      limit: 2000,                     null: false
    t.string   "targetUsername", limit: 2000,                     null: false
    t.string   "targetPW",       limit: 2000,                     null: false
    t.string   "moreLink",       limit: 2000
  end

  create_table "tincanforwardingupdate", force: :cascade do |t|
    t.string   "update_by",  limit: 32, default: "unknown", null: false
    t.datetime "update_dt",                                 null: false
    t.datetime "lastUpdate",                                null: false
  end

  create_table "tincanlaunchtoken", primary_key: "token_id", force: :cascade do |t|
    t.string   "update_by",                limit: 32,   default: "unknown", null: false
    t.datetime "update_dt",                                                 null: false
    t.string   "external_registration_id", limit: 2000,                     null: false
    t.string   "external_configuration",   limit: 2000
    t.datetime "expiry"
  end

  create_table "tincanobjectstore", primary_key: "object_key_sha1", force: :cascade do |t|
    t.string   "update_by",    limit: 32,    default: "unknown", null: false
    t.datetime "update_dt",                                      null: false
    t.string   "object_key",   limit: 255,                       null: false
    t.binary   "object_value", limit: 65535
    t.string   "object_type",  limit: 64,                        null: false
    t.datetime "expiry"
  end

  add_index "tincanobjectstore", ["expiry"], name: "IX_TCOS_e", using: :btree

  create_table "tincanpackage", primary_key: "scorm_package_id", force: :cascade do |t|
    t.string   "update_by",          limit: 32,   default: "unknown", null: false
    t.datetime "update_dt",                                           null: false
    t.string   "tincan_activity_id", limit: 1024,                     null: false
  end

  create_table "tincanpermissions", id: false, force: :cascade do |t|
    t.string   "update_by",       limit: 32,  default: "unknown", null: false
    t.datetime "update_dt",                                       null: false
    t.integer  "app_id",          limit: 4,                       null: false
    t.string   "owner_id",        limit: 100,                     null: false
    t.string   "statement_read",  limit: 64,                      null: false
    t.string   "statement_write", limit: 64,                      null: false
    t.string   "activity_write",  limit: 64,                      null: false
    t.string   "actor_write",     limit: 64,                      null: false
    t.string   "document_read",   limit: 64,                      null: false
    t.string   "document_write",  limit: 64,                      null: false
  end

  create_table "tincanpredicatelog", primary_key: "predicate_id", force: :cascade do |t|
    t.string   "update_by",  limit: 32,  default: "unknown", null: false
    t.datetime "update_dt",                                  null: false
    t.string   "predicates", limit: 512,                     null: false
    t.integer  "count",      limit: 4,                       null: false
  end

  create_table "tincanregistration", primary_key: "scorm_registration_id", force: :cascade do |t|
    t.string   "update_by",              limit: 32,                          default: "unknown", null: false
    t.datetime "update_dt",                                                                      null: false
    t.binary   "tincan_registration_id", limit: 16,                                              null: false
    t.string   "completion",             limit: 20,                                              null: false
    t.string   "success",                limit: 20,                                              null: false
    t.integer  "score_is_known",         limit: 4,                           default: 0,         null: false
    t.decimal  "score",                             precision: 10, scale: 7, default: 0.0,       null: false
    t.integer  "total_seconds_tracked",  limit: 8,                           default: 0,         null: false
    t.string   "comp_of_failed_success", limit: 20,                                              null: false
  end

  create_table "tincanrelatedactivity", id: false, force: :cascade do |t|
    t.string   "update_by",          limit: 32, default: "unknown", null: false
    t.datetime "update_dt",                                         null: false
    t.integer  "app_id",             limit: 4,                      null: false
    t.binary   "statement_id",       limit: 16,                     null: false
    t.binary   "related_actid_sha1", limit: 20,                     null: false
  end

  create_table "tincanrelatedagent", id: false, force: :cascade do |t|
    t.string   "update_by",        limit: 32, default: "unknown", null: false
    t.datetime "update_dt",                                       null: false
    t.integer  "app_id",           limit: 4,                      null: false
    t.binary   "statement_id",     limit: 16,                     null: false
    t.binary   "related_agent_id", limit: 20,                     null: false
  end

  create_table "tincansandboxappids", primary_key: "sandbox_app_id", force: :cascade do |t|
    t.string   "update_by", limit: 32, default: "unknown", null: false
    t.datetime "update_dt",                                null: false
    t.integer  "app_id",    limit: 4,                      null: false
    t.integer  "deleted",   limit: 4,                      null: false
  end

  add_index "tincansandboxappids", ["app_id"], name: "FK_TinCanSandboxAppIds_1", using: :btree

  create_table "tincanstatementindex", id: false, force: :cascade do |t|
    t.string   "update_by",         limit: 32, default: "unknown", null: false
    t.datetime "update_dt",                                        null: false
    t.integer  "app_id",            limit: 4,                      null: false
    t.binary   "statement_id",      limit: 16,                     null: false
    t.integer  "version",           limit: 4
    t.integer  "version_family",    limit: 4
    t.string   "actor_id",          limit: 40
    t.binary   "verb",              limit: 20,                     null: false
    t.binary   "target_id",         limit: 20
    t.string   "target_type",       limit: 32
    t.string   "asserter_id",       limit: 82
    t.integer  "authoritative",     limit: 4
    t.integer  "voided",            limit: 4
    t.integer  "stored",            limit: 8,                      null: false
    t.string   "ctx_instructor_id", limit: 40
    t.binary   "ctx_registration",  limit: 16
  end

  add_index "tincanstatementindex", ["app_id", "stored", "statement_id"], name: "IX_StatementIdx_sortstring", using: :btree
  add_index "tincanstatementindex", ["ctx_registration"], name: "IX_StatementIdx_reg", using: :btree
  add_index "tincanstatementindex", ["statement_id"], name: "IX_StatementIdx_stmtid", using: :btree
  add_index "tincanstatementindex", ["target_id"], name: "IX_StatementIdx_targetid", using: :btree
  add_index "tincanstatementindex", ["verb"], name: "IX_StatementIdx_verb", using: :btree

  create_table "tincantargetstatement", id: false, force: :cascade do |t|
    t.string   "update_by",    limit: 32, default: "unknown", null: false
    t.datetime "update_dt",                                   null: false
    t.integer  "app_id",       limit: 4,                      null: false
    t.binary   "target_id",    limit: 16,                     null: false
    t.binary   "targeting_id", limit: 16,                     null: false
    t.integer  "is_voiding",   limit: 4
  end

  create_table "trainingfield", primary_key: "ID", force: :cascade do |t|
    t.string  "Name",                limit: 32,                 null: false
    t.string  "Description",         limit: 128,                null: false
    t.boolean "WeMarket",                                       null: false
    t.boolean "HasStudentResources",             default: true, null: false
    t.string  "blog_url",            limit: 256
  end

  add_index "trainingfield", ["Name"], name: "UIDX_TrainingField_Name", unique: true, using: :btree

  create_table "trainingfieldcertificateflag", id: false, force: :cascade do |t|
    t.integer "CertificateFlag_ID", limit: 1, null: false
    t.integer "TrainingField_ID",   limit: 1, null: false
    t.boolean "IsRelevant",                   null: false
  end

  add_index "trainingfieldcertificateflag", ["TrainingField_ID"], name: "FK_TrainingFieldCertificateFlag_TrainingField_ID", using: :btree

  create_table "trainingfieldemploymentflag", id: false, force: :cascade do |t|
    t.integer "EmploymentFlag_ID", limit: 1, null: false
    t.integer "TrainingField_ID",  limit: 1, null: false
    t.boolean "IsRelevant",                  null: false
  end

  add_index "trainingfieldemploymentflag", ["TrainingField_ID"], name: "FK_TrainingFieldEmploymentFlag_TrainingField_ID", using: :btree

  create_table "transcriptionsave", id: false, force: :cascade do |t|
    t.integer  "Enrollment_ID", limit: 4,     null: false
    t.integer  "Page_ID",       limit: 3,     null: false
    t.text     "Transcription", limit: 65535, null: false
    t.datetime "Modified",                    null: false
  end

  add_index "transcriptionsave", ["Modified"], name: "IDX_TranscriptionSave_Modified", using: :btree
  add_index "transcriptionsave", ["Page_ID"], name: "FK_TranscriptionSave_Page_ID", using: :btree

  create_table "unit", primary_key: "ID", force: :cascade do |t|
    t.string  "Name",             limit: 64,              null: false
    t.string  "Description",      limit: 64, default: ""
    t.boolean "ShowInNavigation",                         null: false
    t.integer "Partnership_ID",   limit: 2
  end

  add_index "unit", ["Name"], name: "IDX_Unit_Name", using: :btree

  create_table "unitversion", primary_key: "ID", force: :cascade do |t|
    t.integer "Unit_ID", limit: 2,                         null: false
    t.decimal "Version",           precision: 3, scale: 1, null: false
  end

  add_index "unitversion", ["Unit_ID", "Version"], name: "UIDX_UnitVersion_Unit_ID_Version", unique: true, using: :btree

  create_table "unitversioncontents", primary_key: "ID", force: :cascade do |t|
    t.integer "UnitVersion_ID", limit: 2, null: false
    t.integer "SortOrder",      limit: 2, null: false
    t.integer "Page_ID",        limit: 3, null: false
  end

  add_index "unitversioncontents", ["Page_ID"], name: "FK_UnitVersionContents_Page_ID", using: :btree
  add_index "unitversioncontents", ["UnitVersion_ID", "SortOrder"], name: "UIDX_UnitVersionContents_UnitVersion_ID_SortOrder", unique: true, using: :btree

  create_table "unitversioncontentsbranding", id: false, force: :cascade do |t|
    t.integer "UnitVersionContents_ID", limit: 3,   null: false
    t.integer "ProgramBranding_ID",     limit: 2,   null: false
    t.integer "RecordingType_ID",       limit: 1,   null: false
    t.string  "Title",                  limit: 128, null: false
  end

  add_index "unitversioncontentsbranding", ["ProgramBranding_ID"], name: "FK_UnitVersionContentsBranding_ProgramBranding_ID", using: :btree
  add_index "unitversioncontentsbranding", ["RecordingType_ID"], name: "FK_UnitVersionContentsBranding_RecordingType_ID", using: :btree

  create_table "usage_3m_log", id: false, force: :cascade do |t|
    t.datetime "Usage_DT",                null: false
    t.integer  "Enrollment_ID", limit: 4, null: false
  end

  add_index "usage_3m_log", ["Enrollment_ID"], name: "FK_Usage3mLog_Enrollment_ID", using: :btree

  create_table "user", primary_key: "ID", force: :cascade do |t|
    t.integer  "Individual_Contact_ID",     limit: 4,                   null: false
    t.string   "LoginName",                 limit: 64,                  null: false
    t.string   "Password",                  limit: 64,                  null: false
    t.datetime "FirstLoginDateTime"
    t.datetime "NewestLoginDateTime"
    t.integer  "LoginCount",                limit: 4,                   null: false
    t.integer  "BelongsToOrganization_ID",  limit: 4
    t.boolean  "CanAccessTools",                                        null: false
    t.integer  "ToolScopeOrganization_ID",  limit: 4
    t.integer  "ToolScopeTrainingField_ID", limit: 1
    t.string   "Disability",                limit: 13, default: "None", null: false
  end

  add_index "user", ["BelongsToOrganization_ID"], name: "FK_User_BelongsToOrganization_ID", using: :btree
  add_index "user", ["Individual_Contact_ID"], name: "FK_User_Individual_Contact_ID", using: :btree
  add_index "user", ["LoginName"], name: "UIDX_User_LoginName", unique: true, using: :btree
  add_index "user", ["ToolScopeOrganization_ID"], name: "FK_User_ToolScopeOrganization_ID", using: :btree
  add_index "user", ["ToolScopeTrainingField_ID"], name: "FK_User_ToolScopeTrainingField_ID", using: :btree

  create_table "user_group_map", id: false, force: :cascade do |t|
    t.integer "groupID", limit: 4, null: false
    t.integer "userID",  limit: 4, null: false
  end

  create_table "user_message_group", primary_key: "User_Message_Group_ID", force: :cascade do |t|
    t.datetime "Create_DT",                  null: false
    t.integer  "User_ID",          limit: 4, null: false
    t.integer  "Message_Group_ID", limit: 8, null: false
  end

  add_index "user_message_group", ["Message_Group_ID"], name: "FK_MessageGroup_UserMessageGroup", using: :btree
  add_index "user_message_group", ["User_ID"], name: "FK_User_UserMessageGroup", using: :btree

  create_table "user_student_message", primary_key: "User_Student_Message_ID", force: :cascade do |t|
    t.datetime "Viewed_DT"
    t.datetime "Deleted_DT"
    t.integer  "Student_Message_ID", limit: 8, null: false
    t.integer  "User_ID",            limit: 4, null: false
  end

  add_index "user_student_message", ["Student_Message_ID"], name: "FK_StudentMessage_UserStudentMessage", using: :btree
  add_index "user_student_message", ["User_ID"], name: "FK_User_UserStudent_Message", using: :btree

  create_table "usergroup", primary_key: "ID", force: :cascade do |t|
    t.string  "name",   limit: 128, null: false
    t.boolean "active"
  end

  create_table "usermessage", primary_key: "ID", force: :cascade do |t|
    t.string  "Subject",  limit: 255,                     null: false
    t.text    "Message",  limit: 65535,                   null: false
    t.boolean "Reusable",               default: false,   null: false
    t.string  "Tool",     limit: 14,    default: "Other", null: false
  end

  create_table "usermessageattachment", id: false, force: :cascade do |t|
    t.integer "UserMessage_ID",     limit: 4,  null: false
    t.string  "AttachmentFilename", limit: 64, null: false
  end

  create_table "userpartnershiprole", primary_key: "ID", force: :cascade do |t|
    t.integer "User_ID", limit: 4, null: false
    t.integer "Role_ID", limit: 1, null: false
  end

  add_index "userpartnershiprole", ["Role_ID"], name: "FK_UserPartnershipRole_Role_ID", using: :btree
  add_index "userpartnershiprole", ["User_ID", "Role_ID"], name: "UIDX_UserPartnershipRole_User_ID_Partnership_ID_Role_ID", unique: true, using: :btree

  create_table "version", id: false, force: :cascade do |t|
    t.integer  "Version",         limit: 4, null: false
    t.integer  "Minor_Version",   limit: 4, null: false
    t.datetime "VersionDateTime",           null: false
  end

  create_table "websitecontactinfo", primary_key: "ID", force: :cascade do |t|
    t.string "Hours", limit: 128
    t.string "Email", limit: 128
    t.string "Phone", limit: 128
    t.string "URL",   limit: 128
  end

#  add_foreign_key "address", "contact", column: "Contact_ID", primary_key: "ID", name: "FK_Address_Contact_ID", on_update: :cascade, on_delete: :cascade
#  add_foreign_key "address", "state", column: "State_ID", primary_key: "ID", name: "FK_Address_State_ID", on_update: :cascade
  add_foreign_key "announcement", "user", column: "Author_User_ID", primary_key: "ID", name: "FK_Announcement_User_ID", on_update: :cascade
  add_foreign_key "applicationcontacthistory", "employerapplicationhistory", column: "EmployerApplicationHistory_ID", primary_key: "ID", name: "FK_ApplicationContactHistory_EmployerApplicationHistory_ID", on_update: :cascade, on_delete: :cascade
#  add_foreign_key "assessment", "assessmenttype", column: "AssessmentType_ID", primary_key: "ID", name: "fk_assessment_assessmenttype_1"
#  add_foreign_key "assessment", "license", column: "License_ID", primary_key: "ID", name: "assessment_ibfk_2"
#  add_foreign_key "assessment", "partnership", column: "Partnership_ID", primary_key: "ID", name: "assessment_ibfk_3"
  add_foreign_key "assessmentcontents", "assessment", column: "Assessment_ID", primary_key: "ID", name: "assessmentcontents_ibfk_1"
  add_foreign_key "assessmentcontents", "stage", column: "Stage_ID", primary_key: "ID", name: "assessmentcontents_ibfk_2"
#  add_foreign_key "assessmentprogramversion", "assessment", column: "Assessment_ID", primary_key: "ID", name: "assessmentprogramversion_ibfk_1", on_delete: :cascade
#  add_foreign_key "assessmentprogramversion", "programversion", column: "ProgramVersion_ID", primary_key: "ID", name: "assessmentprogramversion_ibfk_2", on_delete: :cascade
#  add_foreign_key "assessmentquestion", "questiontype", column: "QuestionType_ID", primary_key: "ID", name: "assessmentquestion_ibfk_2"
  # add_foreign_key "assessmentrecord", "assessment", column: "Assessment_ID", primary_key: "ID", name: "assessmentrecord_ibfk_4"
  # add_foreign_key "assessmentrecord", "licenseversion", column: "LicenseVersion_ID", primary_key: "ID", name: "assessmentrecord_ibfk_3"
  # add_foreign_key "assessmentrecord", "user", column: "User_ID", primary_key: "ID", name: "assessmentrecord_ibfk_1"
  # add_foreign_key "block", "blockset", column: "BlockSet_ID", primary_key: "ID", name: "FK_Block_BlockSet_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "blockaccessemail", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "blockaccessemail_ibfk_1", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "blockaccessstart", "block", column: "Block_ID", primary_key: "ID", name: "blockaccessstart_ibfk_2", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "blockaccessstart", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "blockaccessstart_ibfk_1", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "blockcontents", "block", column: "Block_ID", primary_key: "ID", name: "FK_BlockContents_Block_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "blockcontents", "module", column: "Module_ID", primary_key: "ID", name: "FK_BlockContents_Module_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "blockmaterial", "block", column: "Block_ID", primary_key: "ID", name: "FK_BlockMaterial_Block_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "blockmaterial", "material", column: "Material_ID", primary_key: "ID", name: "FK_BlockMaterial_Material_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "blockset", "partnership", column: "Partnership_ID", primary_key: "ID", name: "FK_BlockSet_Partnership_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "blockset", "programversion", column: "ProgramVersion_ID", primary_key: "ID", name: "FK_BlockSet_ProgramVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "campaign_timeframe", "campaign", column: "Campaign_ID", primary_key: "ID", name: "FK_Campaign_ID"
  # add_foreign_key "campaign_timeframe", "promocode", column: "PromoCode_ID", primary_key: "ID", name: "FK_PromoCode_ID"
  # add_foreign_key "campaign_timeframe_image_clicklog", "extension_notification_image", column: "Extension_Notification_Image_ID", primary_key: "ID", name: "campaign_timeframe_image_clicklog_ibfk_1", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "campaign_timeframe_image_clicklog", "user", column: "User_ID", primary_key: "ID", name: "campaign_timeframe_image_clicklog_ibfk_2", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "campaign_timeframe_viewlog", "campaign_timeframe", column: "Campaign_Timeframe_ID", primary_key: "ID", name: "campaign_timeframe_viewlog_ibfk_1", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "campaign_timeframe_viewlog", "user", column: "User_ID", primary_key: "ID", name: "campaign_timeframe_viewlog_ibfk_2", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "candidateemployer", "jobseeker", column: "JobSeeker_ID", primary_key: "ID", name: "FK_CandidateEmployer_JobSeeker_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "candidateemployer", "trainingfield", column: "TrainingField_ID", primary_key: "ID", name: "FK_CandidateEmployer_TrainingField_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "categorytrainingfield", "category", column: "Category_ID", primary_key: "ID", name: "FK_CategoryTrainingField_Category_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "categorytrainingfield", "trainingfield", column: "TrainingField_ID", primary_key: "ID", name: "FK_CategoryTrainingField_TrainingField_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "changepasswordrequest", "user", column: "User_ID", primary_key: "ID", name: "FK_ChangePasswordRequest_User_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "class", "partnership", column: "Partnership_ID", primary_key: "ID", name: "FK_Class_Partnership_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "class", "programbranding", column: "ProgramBranding_ID", primary_key: "ID", name: "FK_Class_ProgramBranding_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "classannouncement", "announcement", column: "Announcement_ID", primary_key: "ID", name: "FK_ClassAnnouncement_Announcement_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "classannouncement", "class", column: "Class_ID", primary_key: "ID", name: "FK_ClassAnnouncement_Class_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "classinstructor", "class", column: "Class_ID", primary_key: "ID", name: "FK_ClassInstructor_Class_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "classinstructor", "user", column: "User_ID", primary_key: "ID", name: "FK_ClassInstructor_User_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "classstudent", "class", column: "Class_ID", primary_key: "ID", name: "FK_ClassStudent_Class_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "classstudent", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_ClassStudent_Enrollment_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "companionprogram", "program", column: "CompanionProgram_ID", primary_key: "ID", name: "FK_CompanionProgram_CompanionProgram_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "companionprogram", "program", column: "Program_ID", primary_key: "ID", name: "FK_CompanionProgram_Program_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "email", "contact", column: "Contact_ID", primary_key: "ID", name: "FK_Email_Contact_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "emailhistory", "employer", column: "Employer_ID", primary_key: "ID", name: "FK_EmailHistory_Employer_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "emailhistory", "user", column: "SentByUser_ID", primary_key: "ID", name: "FK_EmailHistory_SentByUser_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "emailhistory", "usermessage", column: "UserMessage_ID", primary_key: "ID", name: "FK_EmailHistory_UserMessage_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "emailonstartdate", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_EmailOnStartDate_Enrollment_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "employer", "jobseeker", column: "ReferredByJobSeeker_ID", primary_key: "ID", name: "FK_Employer_ReferredByJobSeeker_ID", on_update: :cascade, on_delete: :nullify
  # add_foreign_key "employer", "partnership", column: "Partnership_ID", primary_key: "ID", name: "FK_Employer_Partnership_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "employer", "trainingfield", column: "TrainingField_ID", primary_key: "ID", name: "FK_Employer_TrainingField_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "employerapplicationhistory", "employer", column: "Employer_ID", primary_key: "ID", name: "FK_EmployerApplicationHistory_Employer_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "employerapplicationhistory", "jobseeker", column: "JobSeeker_ID", primary_key: "ID", name: "FK_EmployerApplicationHistory_JobSeeker_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "employercertificateflag", "certificateflag", column: "CertificateFlag_ID", primary_key: "ID", name: "FK_EmployerCertificateFlag_CertificateFlag_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "employercertificateflag", "employer", column: "Employer_ID", primary_key: "ID", name: "FK_EmployerCertificateFlag_Employer_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "employeremploymentflag", "employer", column: "Employer_ID", primary_key: "ID", name: "FK_EmployerEmploymentFlag_Employer_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "employeremploymentflag", "employmentflag", column: "EmploymentFlag_ID", primary_key: "ID", name: "FK_EmployerEmploymentFlag_EmploymentFlag_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "employerparticipationhistory", "employer", column: "Employer_ID", primary_key: "ID", name: "FK_EmployerParticipationHistory_Employer_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "employmentflag", "employmentflaggroup", column: "EmploymentFlagGroup_ID", primary_key: "ID", name: "FK_EmploymentFlag_EmploymentFlagGroup_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "enrollment", "blockset", column: "BlockSet_ID", primary_key: "ID", name: "FK_Enrollment_BlockSet_ID", on_update: :cascade
  # add_foreign_key "enrollment", "enrollmentfundingsource", column: "EnrollmentFundingSource_ID", primary_key: "ID", name: "enrollment_ibfk_1"
  # add_foreign_key "enrollment", "funding_source", column: "Funding_Source_ID", primary_key: "Funding_Source_ID", name: "FK_Enrollment_Funding_Source_ID"
  # add_foreign_key "enrollment", "licenseversion", column: "LicenseVersion_ID", primary_key: "ID", name: "FK_Enrollment_LicenseVersion_ID", on_update: :cascade
  # add_foreign_key "enrollment", "programbranding", column: "ProgramBranding_ID", primary_key: "ID", name: "FK_Enrollment_ProgramBranding_ID", on_update: :cascade
  # add_foreign_key "enrollment", "statuschangereason", column: "StatusChangeReason_ID", primary_key: "ID", name: "FK_Enrollment_StatusChangeReason_ID", on_update: :cascade
  # add_foreign_key "enrollment", "themeinfo", column: "ThemeInfo_ID", primary_key: "ID", name: "FK_Enrollment_ThemeInfo_ID", on_update: :cascade
  # add_foreign_key "enrollment", "thresholdcollection", column: "ThresholdCollection_ID", primary_key: "ID", name: "FK_Enrollment_ThresholdCollection_ID", on_update: :cascade
  # add_foreign_key "enrollment", "user", column: "ModifiedBy_User_ID", primary_key: "ID", name: "FK_Enrollment_ModifiedBy_User_ID", on_update: :cascade
  # add_foreign_key "enrollment", "user", column: "User_ID", primary_key: "ID", name: "FK_Enrollment_User_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "enrollmentemailhistory", "emailhistory", column: "EmailHistory_ID", primary_key: "ID", name: "FK_EnrollmentEmailRecipientHistory_EmailHistory_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "enrollmentemailhistory", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_EnrollmentEmailRecipientHistory_Enrollment_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "enrollmentlevel", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "enrollmentlevel_ibfk_1", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "enrollmentplacemark", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_EnrollmentPlacemark_Enrollment_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "enrollmentplacemark", "moduleversion", column: "ModuleVersion_ID", primary_key: "ID", name: "FK_EnrollmentPlacemark_ModuleVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "events", "assessment", column: "Assessment_ID", primary_key: "ID", name: "events_ibfk_1"
  # add_foreign_key "events", "eventaction", column: "EventAction_ID", primary_key: "ID", name: "events_ibfk_3"
  # add_foreign_key "events", "eventtype", column: "EventType_ID", primary_key: "ID", name: "events_ibfk_5"
  # add_foreign_key "events", "stage", column: "EventActionStage_ID", primary_key: "ID", name: "events_ibfk_2"
  # add_foreign_key "events", "stage", column: "EventStage_ID", primary_key: "ID", name: "events_ibfk_4"
  # add_foreign_key "exam", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_Exam_Enrollment_Enrollment_ID"
  # add_foreign_key "exam", "user", column: "Grader_User_ID", primary_key: "ID", name: "FK_Exam_User_Grader_User_ID"
  # add_foreign_key "exam_question", "exam", column: "Exam_ID", primary_key: "Exam_ID", name: "FK_ExamQuestion_Exam_Exam_ID"
  # add_foreign_key "exam_question", "question", column: "Question_ID", primary_key: "Question_ID", name: "FK_ExamQuestion_Question_Question_ID"
  # add_foreign_key "exam_question", "question_group", column: "Question_Group_ID", primary_key: "Question_Group_ID", name: "FK_ExamQuestion_QuestionGroup_Question_Group_ID"
  # add_foreign_key "exam_question_group", "exam", column: "Exam_ID", primary_key: "Exam_ID", name: "FK_ExamQuestionGroup_Exam_Exam_ID"
  # add_foreign_key "exam_question_group", "question_group", column: "Question_Group_ID", primary_key: "Question_Group_ID", name: "FK_ExamQuestionGroup_QuestionGroup_Question_Group_ID"
  # add_foreign_key "extension", "programversion", column: "ProgramVersion_ID", primary_key: "ID", name: "FK_Extension_ProgramVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "extension_notification_image", "campaign_timeframe", column: "Campaign_TimeFrame_ID", primary_key: "ID", name: "FK_CampaignTimeFrame"
  # add_foreign_key "extension_promo_message", "extension", column: "Extension_ID", primary_key: "ID", name: "extension_promo_message_ibfk_2", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "extension_promo_message", "extension_notification_timeframe", column: "Extension_Notification_Timeframe_ID", primary_key: "ID", name: "extension_promo_message_ibfk_1", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "extensionpurchaselog", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_ExtensionPurchaseLog_Enrollment", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "faq", "faq_header", column: "FAQ_Header_ID", primary_key: "FAQ_Header_ID", name: "FK_FAQ_FAQ_Header_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "faq", "module", column: "Module_ID", primary_key: "ID", name: "FK_FAQ_Module_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "faq", "programversion", column: "ProgramVersion_ID", primary_key: "ID", name: "FK_FAQ_ProgramVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "gameboardscore", "gameboard", column: "GameBoard_ID", primary_key: "ID", name: "FK_GameBoardScore_GameBoard_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "gameboardscore", "user", column: "User_ID", primary_key: "ID", name: "FK_GameBoardScore_User_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "gamefakename", "user", column: "User_ID", primary_key: "ID", name: "FK_GameFakeName_User_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "generalannouncement", "announcement", column: "Announcement_ID", primary_key: "ID", name: "FK_GeneralAnnouncement_Announcement_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "generalannouncement", "trainingfield", column: "TrainingField_ID", primary_key: "ID", name: "FK_GeneralAnnouncement_TrainingField_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "generalannouncement_announcementflag", "announcementflag", column: "AnnouncementFlag_ID", primary_key: "ID", name: "FK_GeneralAnnouncement_AnnouncementFlag_AnnouncementFlag_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "generalannouncement_announcementflag", "generalannouncement", column: "GeneralAnnouncement_ID", primary_key: "Announcement_ID", name: "FK_GeneralAnnouncement_AnnouncementFlag_Announcement_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "graduate", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_Graduate_Enrollment_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "graduate", "user", column: "ModifiedBy_User_ID", primary_key: "ID", name: "FK_Graduate_ModifiedBy_User_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "howbecameinterested", "contactsource", column: "ContactSource_ID", primary_key: "ID", name: "FK_HowBecameInterested_ContactSource_ID", on_update: :cascade
  # add_foreign_key "howbecameinterested", "individual", column: "ReferrerIndividual_ID", primary_key: "Contact_ID", name: "FK_HowBecameInterested_ReferrerIndividual_ID", on_update: :cascade
  # add_foreign_key "howbecameinterested", "partnership", column: "TestingPartnership_ID", primary_key: "ID", name: "FK_HowBecameInterested_TestingPartnership_ID", on_update: :cascade
  # add_foreign_key "howbecameinterested", "partnership", column: "TrainingPartnership_ID", primary_key: "ID", name: "FK_HowBecameInterested_TrainingPartnership_ID", on_update: :cascade
  # add_foreign_key "individual", "contact", column: "Contact_ID", primary_key: "ID", name: "FK_Individual_Contact_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "informationrequest", "howbecameinterested", column: "HowBecameInterested_ID", primary_key: "ID", name: "FK_InformationRequest_HowBecameInterested_ID", on_update: :cascade
  # add_foreign_key "informationrequest", "individual", column: "Individual_ID", primary_key: "Contact_ID", name: "FK_InformationRequest_Individual_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "informationrequest", "trainingfield", column: "TrainingField_ID", primary_key: "ID", name: "FK_InformationRequest_TrainingField_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "instanceanswer", "instancegroup", column: "InstanceGroup_ID", primary_key: "ID", name: "FK_InstanceAnswer_InstanceGroup_ID"
  # add_foreign_key "instanceanswer", "questionresource", column: "QuestionResource_ID", primary_key: "ID", name: "FK_InstanceAnswer_QuestionResource_ID"
  # add_foreign_key "instanceanswertext", "instanceanswer", column: "InstanceAnswer_ID", primary_key: "ID", name: "FK_InstanceAnswerText_InstanceAnswer_ID"
  # add_foreign_key "instancegroup", "instancestage", column: "InstanceStage_ID", primary_key: "ID", name: "FK_InstanceGroup_InstanceStage_ID"
  # add_foreign_key "instancegroup", "questiongroup", column: "QuestionGroup_ID", primary_key: "ID", name: "FK_InstanceGroup_QuestionGroup_ID"
  # add_foreign_key "instancegroup", "questionversion", column: "QuestionVersion_ID", primary_key: "ID", name: "FK_InstanceGroup_QuestionVersion_ID"
  # add_foreign_key "instancestage", "assessmentinstance", column: "Instance_ID", primary_key: "ID", name: "FK_InstanceStage_AssessmentInstance_ID"
  # add_foreign_key "instancestage", "stage", column: "Stage_ID", primary_key: "ID", name: "FK_InstanceStage_Stage_ID"
  # add_foreign_key "instancestatuslog", "instancestate", column: "InstanceState_ID", primary_key: "ID", name: "FK_InstanceStatusLog_InstanceState_ID"
  # add_foreign_key "instancestatuslog", "user", column: "Updater_User_ID", primary_key: "ID", name: "FK_InstanceStatusLog_User_ID"
  # add_foreign_key "jobseeker", "enrollment", column: "Graduate_Enrollment_ID", primary_key: "ID", name: "FK_JobSeeker_Graduate_Enrollment_ID", on_update: :cascade, on_delete: :nullify
  # add_foreign_key "jobseeker", "enrollment", column: "Tutorial_Enrollment_ID", primary_key: "ID", name: "FK_JobSeeker_Tutorial_Enrollment_ID", on_update: :cascade, on_delete: :nullify
  # add_foreign_key "jobseeker", "statuschangereason", column: "StatusChangeReason_ID", primary_key: "ID", name: "FK_JobSeeker_StatusChangeReason_ID", on_update: :cascade
  # add_foreign_key "jobseeker", "trainingfield", column: "TrainingField_ID", primary_key: "ID", name: "FK_JobSeeker_TrainingField_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "jobseeker", "user", column: "ModifiedBy_User_ID", primary_key: "ID", name: "FK_JobSeeker_ModifiedBy_User_ID", on_update: :cascade
  # add_foreign_key "jobseeker", "user", column: "User_ID", primary_key: "ID", name: "FK_JobSeeker_User_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "jobseekercertificateflag", "certificateflag", column: "CertificateFlag_ID", primary_key: "ID", name: "FK_JobSeekerCertificateFlag_CertificateFlag_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "jobseekercertificateflag", "jobseeker", column: "JobSeeker_ID", primary_key: "ID", name: "FK_JobSeekerCertificateFlag_JobSeeker_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "jobseekeremailhistory", "emailhistory", column: "EmailHistory_ID", primary_key: "ID", name: "FK_JobSeekerEmailRecipientHistory_EmailHistory_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "jobseekeremailhistory", "jobseeker", column: "JobSeeker_ID", primary_key: "ID", name: "FK_JobSeekerEmailRecipientHistory_JobSeeker_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "jobseekeremploymentflag", "employmentflag", column: "EmploymentFlag_ID", primary_key: "ID", name: "FK_JobSeekerEmploymentFlag_EmploymentFlag_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "jobseekeremploymentflag", "jobseeker", column: "JobSeeker_ID", primary_key: "ID", name: "FK_JobSeekerEmploymentFlag_JobSeeker_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "jobseekeremploymenthistory", "employer", column: "Employer_ID", primary_key: "ID", name: "FK_JobSeekerEmploymentHistory_Employer_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "jobseekeremploymenthistory", "jobseeker", column: "JobSeeker_ID", primary_key: "ID", name: "FK_JobSeekerEmploymentHistory_JobSeeker_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "jobseekerspecialty", "jobseekeremploymenthistory", column: "JobSeekerEmploymentHistory_ID", primary_key: "ID", name: "FK_JobSeekerSpecialty_JobSeekerEmploymentHistory_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "jobseekerspecialty", "specialty", column: "Specialty_ID", primary_key: "ID", name: "FK_JobSeekerSpecialty_Specialty_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "jobseekerstatushistory", "jobseeker", column: "JobSeeker_ID", primary_key: "ID", name: "FK_JobSeekerStatusHistory_JobSeeker_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "jobseekerstatushistory", "statuschangereason", column: "StatusChangeReason_ID", primary_key: "ID", name: "FK_JobSeekerStatusHistory_StatusChangeReason_ID", on_update: :cascade
  # add_foreign_key "jobseekerstatushistory", "user", column: "ModifiedBy_User_ID", primary_key: "ID", name: "FK_JobSeekerStatusHistory_ModifiedBy_User_ID", on_update: :cascade
  # add_foreign_key "legacytrainingcertificate", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_LegacyTrainingCertificate_Enrollment_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "licenseversion", "license", column: "License_ID", primary_key: "ID", name: "FK_LicenseVersion_License_ID", on_update: :cascade
  # add_foreign_key "login_history", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "login_history_ibfk_1", on_delete: :cascade
  # add_foreign_key "login_history", "programbranding", column: "ProgramBranding_ID", primary_key: "ID", name: "login_history_ibfk_2", on_delete: :cascade
  # add_foreign_key "marketingcontact", "individual", column: "Individual_ID", primary_key: "Contact_ID", name: "FK_MarketingContact_Individual_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "materialrequest", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_MaterialRequest_Enrollment_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "materialrequest", "material", column: "Material_ID", primary_key: "ID", name: "FK_MaterialRequest_Material_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "message_group", "class", column: "Class_ID", primary_key: "ID", name: "FK_Class_MessageGroup", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "missingpronunciation", "trainingfield", column: "TrainingField_ID", primary_key: "ID", name: "FK_MissingPronunciation_TrainingField_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "module", "copyrightwatermarkgroup", column: "CopyrightWatermarkGroup_ID", primary_key: "ID", name: "FK_Module_CopyrightWatermarkGroup_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "module_map", "moduleversion", column: "From_ModuleVersion_ID", primary_key: "ID", name: "FK_Module_Map_FromModuleVersionID"
  # add_foreign_key "module_map", "moduleversion", column: "To_ModuleVersion_ID", primary_key: "ID", name: "FK_Module_Map_ToModuleVersionID"
  # add_foreign_key "module_map", "user", column: "Last_Update_User_ID", primary_key: "ID", name: "FK_Module_Map_LastUpdateUserID"
  # add_foreign_key "module_map_page_info", "module_map", column: "Module_Map_ID", primary_key: "Module_Map_ID", name: "FK_ModuleMapPageInfo_ModuleMapID"
  # add_foreign_key "module_map_page_info", "page", column: "From_Page_ID", primary_key: "ID", name: "FK_ModuleMapPageInfo_FromPageID"
  # add_foreign_key "module_map_page_info", "page", column: "To_Page_ID", primary_key: "ID", name: "FK_ModuleMapPageInfo_ToPageID"
  # add_foreign_key "modulebranding", "module", column: "Module_ID", primary_key: "ID", name: "FK_ModuleBranding_Module_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "modulebranding", "programbranding", column: "ProgramBranding_ID", primary_key: "ID", name: "FK_ModuleBranding_ProgramBranding_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "moduleversion", "module", column: "Module_ID", primary_key: "ID", name: "FK_ModuleVersion_Module_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "moduleversionaccess", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_ModuleVersionAccess_Enrollment_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "moduleversionaccess", "moduleversion", column: "ModuleVersion_ID", primary_key: "ID", name: "FK_ModuleVersionAccess_ModuleVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "moduleversionaccess", "statuschangereason", column: "StatusChangeReason_ID", primary_key: "ID", name: "FK_ModuleVersionAccess_StatusChangeReason_ID", on_update: :cascade
  # add_foreign_key "moduleversionaccess", "user", column: "ModifiedBy_User_ID", primary_key: "ID", name: "FK_ModuleVersionAccess_ModifiedBy_User_ID", on_update: :cascade
  # add_foreign_key "moduleversionaccesshistory", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_ModuleVersionAccessHistory_Enrollment_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "moduleversionaccesshistory", "moduleversion", column: "ModuleVersion_ID", primary_key: "ID", name: "FK_ModuleVersionAccessHistory_ModuleVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "moduleversionaccesshistory", "statuschangereason", column: "StatusChangeReason_ID", primary_key: "ID", name: "FK_ModuleVersionAccessHistory_StatusChangeReason_ID", on_update: :cascade
  # add_foreign_key "moduleversionaccesshistory", "user", column: "ModifiedBy_User_ID", primary_key: "ID", name: "FK_ModuleVersionAccessHistory_ModifiedBy_User_ID", on_update: :cascade
  # add_foreign_key "moduleversioncontents", "moduleversion", column: "ModuleVersion_ID", primary_key: "ID", name: "FK_ModuleVersionContents_ModuleVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "moduleversioncontents", "unitversion", column: "UnitVersion_ID", primary_key: "ID", name: "FK_ModuleVersionContents_UnitVersion_ID", on_update: :cascade
  # add_foreign_key "moduleversionupgrade", "moduleversion", column: "New_ModuleVersion_ID", primary_key: "ID", name: "FK_ModuleVersionUpgrade_New_ModuleVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "moduleversionupgrade", "moduleversion", column: "Old_ModuleVersion_ID", primary_key: "ID", name: "FK_ModuleVersionUpgrade_Old_ModuleVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "organization", "contact", column: "Contact_ID", primary_key: "ID", name: "FK_Organization_Contact_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "organizationindividualcontact", "individual", column: "Individual_ID", primary_key: "Contact_ID", name: "FK_OrganizationIndividualContact_Individual_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "organizationindividualcontact", "organization", column: "Organization_ID", primary_key: "Contact_ID", name: "FK_OrganizationIndividualContact_Organization_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "page", "activity", column: "Activity_ID", primary_key: "ID", name: "FK_Page_Activity_ID", on_update: :cascade
  # add_foreign_key "page", "module", column: "Module_ID", primary_key: "ID", name: "FK_Page_Module_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "page", "recordingtype", column: "RecordingType_ID", primary_key: "ID", name: "FK_Page_RecordingType_ID", on_update: :cascade
  # add_foreign_key "pageoffsetlookup", "moduleversion", column: "ModuleVersion_ID", primary_key: "ID", name: "FK_PageOffsetLookup_ModuleVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "pageoffsetlookup", "page", column: "Page_ID", primary_key: "ID", name: "FK_PageOffsetLookup_Page_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "pagerawscore", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_PageRawScore_Enrollment_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "pagerawscore", "moduleversion", column: "ModuleVersion_ID", primary_key: "ID", name: "FK_PageRawScore_ModuleVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "pagerawscoredeleted", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_PageRawScoreDeleted_Enrollment_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "pagerawscoredeleted", "moduleversion", column: "ModuleVersion_ID", primary_key: "ID", name: "FK_PageRawScoreDeleted_ModuleVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "pagescore", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_PageScore_Enrollment_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "pagescore", "moduleversion", column: "ModuleVersion_ID", primary_key: "ID", name: "FK_PageScore_ModuleVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "pagescoredeleted", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_PageScoreDeleted_Enrollment_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "pagescoredeleted", "moduleversion", column: "ModuleVersion_ID", primary_key: "ID", name: "FK_PageScoreDeleted_ModuleVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "pagetimespent", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_PageTimeSpent_Enrollment_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "pagetimespent", "moduleversion", column: "ModuleVersion_ID", primary_key: "ID", name: "FK_PageTimeSpent_ModuleVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "pagetimespentdeleted", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_PageTimeSpentDeleted_Enrollment_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "pagetimespentdeleted", "moduleversion", column: "ModuleVersion_ID", primary_key: "ID", name: "FK_PageTimeSpentDeleted_ModuleVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "pagetimespentlog", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_PageTimeSpentLog_Enrollment_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "partner", "organization", column: "Organization_Contact_ID", primary_key: "Contact_ID", name: "FK_Partner_Organization_Contact_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "partner", "themeinfo", column: "ThemeInfo_ID", primary_key: "ID", name: "FK_Partner_ThemeInfo_ID", on_update: :cascade
  # add_foreign_key "partnership", "partner", column: "Partner_ID", primary_key: "ID", name: "FK_Partnership_Partner_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "partnership", "partnershiptype", column: "PartnershipType_ID", primary_key: "ID", name: "FK_Partnership_PartnershipType_ID", on_update: :cascade
  # add_foreign_key "partnership_announcementflag", "announcementflag", column: "AnnouncementFlag_ID", primary_key: "ID", name: "FK_Partnership_AnnouncementFlag_AnnouncementFlag_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "partnership_announcementflag", "partnership", column: "Partnership_ID", primary_key: "ID", name: "FK_Partnership_AnnouncementFlag_Partnership_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "partnershipacademiccalendar", "partnership", column: "Partnership_ID", primary_key: "ID", name: "FK_PartnershipAcademicCalendar_Partnership_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "partnershipannouncement", "announcement", column: "Announcement_ID", primary_key: "ID", name: "FK_PartnershipAnnouncement_Announcement_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "partnershipannouncement", "partnership", column: "Partnership_ID", primary_key: "ID", name: "FK_PartnershipAnnouncement_Partnership_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "partnershipannouncement", "programbranding", column: "ProgramBranding_ID", primary_key: "ID", name: "FK_PartnershipAnnouncement_ProgramBranding_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "penscommandscormpackage", "penscommand", column: "pens_command_id", primary_key: "pens_command_id", name: "FK_PensCommandScormPackage_1"
  # add_foreign_key "penscommandscormpackage", "scormpackage", column: "scorm_package_id", primary_key: "scorm_package_id", name: "FK_PensCommandScormPackage_2"
  # add_foreign_key "phone", "contact", column: "Contact_ID", primary_key: "ID", name: "FK_Phone_Contact_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "placementdirectspotlight", "trainingfield", column: "TrainingField_ID", primary_key: "ID", name: "FK_PlacementDirectSpotLight_TrainingField_ID", on_update: :cascade
  # add_foreign_key "placementdirectwelcomemessage", "trainingfield", column: "TrainingField_ID", primary_key: "ID", name: "FK_PlacementDirectWelcomeMessage_TrainingField_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "program", "license", column: "License_ID", primary_key: "ID", name: "FK_Program_License_ID", on_update: :cascade
  # add_foreign_key "program", "partnership", column: "Partnership_ID", primary_key: "ID", name: "FK_Program_Partnership_ID", on_update: :cascade
  # add_foreign_key "program", "program", column: "Final_Program_ID", primary_key: "ID", name: "FK_Program_Program_Final_Program_ID"
  # add_foreign_key "program", "programtype", column: "ProgramType_ID", primary_key: "ID", name: "FK_Program_ProgramType", on_update: :cascade
  # add_foreign_key "program", "trainingfield", column: "TrainingField_ID", primary_key: "ID", name: "FK_Program_TrainingField_ID", on_update: :cascade
  # add_foreign_key "program", "user", column: "Creator_User_ID", primary_key: "ID", name: "FK_Program_User_Creator_User_ID"
  # add_foreign_key "program_final_exam", "program", column: "Program_ID", primary_key: "ID", name: "FK_ProgramFinalExam_Program_ID"
  # add_foreign_key "programbranding", "message", column: "AddEnrollmentDefaultEmailMessage_ID", primary_key: "ID", name: "FK_ProgramBranding_AddEnrollmentDefaultEmailMessage_ID", on_update: :cascade
  # add_foreign_key "programbranding", "message", column: "BlockUpdateDefaultEmailMessage_ID", primary_key: "ID", name: "FK_Message_ProgramBranding_BlockUpdateDefaultEmailMessage_ID", on_update: :cascade
  # add_foreign_key "programbranding", "partnership", column: "Partnership_ID", primary_key: "ID", name: "FK_ProgramBranding_Partnership_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "programbranding", "program", column: "Program_ID", primary_key: "ID", name: "FK_ProgramBranding_Program_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "programbranding", "programbranding_threshold", column: "ProgramBranding_Threshold_ID", primary_key: "ID", name: "programbranding_ibfk_1", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "programbranding", "programcustomization", column: "ProgramCustomization_ID", primary_key: "ID", name: "FK_ProgramBranding_ProgramCustomization_ID", on_update: :cascade
  # add_foreign_key "programbranding", "themeinfo", column: "ThemeInfo_ID", primary_key: "ID", name: "FK_ProgramBranding_ThemeInfo_ID", on_update: :cascade
  # add_foreign_key "programbrandingaddon", "addon", column: "Addon_ID", primary_key: "ID", name: "FK_ProgramBrandingAddon_Addon", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "programbrandingaddon", "programbranding", column: "ProgramBranding_ID", primary_key: "ID", name: "FK_ProgramBrandingAddon_ProgramBranding", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "programbrandingblockset", "blockset", column: "BlockSet_ID", primary_key: "ID", name: "FK_ProgramBrandingBlockSet_BlockSet_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "programbrandingblockset", "programbranding", column: "ProgramBranding_ID", primary_key: "ID", name: "FK_ProgramBrandingBlockSet_ProgramBranding_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "programbrandingprice", "programbranding", column: "ProgramBranding_ID", primary_key: "ID", name: "FK_ProgramBrandingPrice_ProgramBranding", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "programcustomization", "thresholdcollection", column: "ThresholdCollection_ID", primary_key: "ID", name: "FK_ProgramCustomization_ThresholdCollection_ID", on_update: :cascade
  # add_foreign_key "programcustomization", "websitecontactinfo", column: "Shipping_WebsiteContactInfo_ID", primary_key: "ID", name: "FK_ProgramCustomization_Shipping_WebsiteContactInfo_ID", on_update: :cascade
  # add_foreign_key "programcustomization", "websitecontactinfo", column: "Support_WebsiteContactInfo_ID", primary_key: "ID", name: "FK_ProgramCustomization_Support_WebsiteContactInfo_ID", on_update: :cascade
  # add_foreign_key "programcustomization", "websitecontactinfo", column: "TechSupport_WebsiteContactInfo_ID", primary_key: "ID", name: "FK_ProgramCustomization_TechSupport_WebsiteContactInfo_ID", on_update: :cascade
  # add_foreign_key "programversion", "program", column: "Program_ID", primary_key: "ID", name: "FK_ProgramVersion_Program_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "programversionaccesshistory", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_ProgramVersionAccessHistory_Enrollment_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "programversionaccesshistory", "programversion", column: "ProgramVersion_ID", primary_key: "ID", name: "FK_ProgramVersionAccessHistory_ProgramVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "programversionaccesshistory", "statuschangereason", column: "StatusChangeReason_ID", primary_key: "ID", name: "FK_ProgramVersionAccessHistory_StatusChangeReason_ID", on_update: :cascade
  # add_foreign_key "programversionaccesshistory", "user", column: "ModifiedBy_User_ID", primary_key: "ID", name: "FK_ProgramVersionAccessHistory_ModifiedBy_User_ID", on_update: :cascade
  # add_foreign_key "programversioncontents", "module", column: "Module_ID", primary_key: "ID", name: "FK_ProgramVersionContents_Module_ID", on_update: :cascade
  # add_foreign_key "programversioncontents", "programversion", column: "ProgramVersion_ID", primary_key: "ID", name: "FK_ProgramVersionContents_ProgramVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "programversionupgrade", "programversion", column: "New_ProgramVersion_ID", primary_key: "ID", name: "FK_ProgramVersionUpgrade_New_ProgramVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "programversionupgrade", "programversion", column: "Old_ProgramVersion_ID", primary_key: "ID", name: "FK_ProgramVersionUpgrade_Old_ProgramVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "promocodeusage", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_PromoCodeUsage_EnrollmentID"
  # add_foreign_key "pronunciationcategory", "category", column: "Category_ID", primary_key: "ID", name: "FK_PronunciationCategory_Category_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "pronunciationcategory", "pronunciation", column: "Pronunciation_ID", primary_key: "ID", name: "FK_PronunciationCategory_Pronunciation_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "question", "question_group", column: "Question_Group_ID", primary_key: "Question_Group_ID", name: "FK_Question_QuestionGroup_Question_Group_ID"
  # add_foreign_key "question_answer", "question", column: "Question_ID", primary_key: "Question_ID", name: "FK_QuestionAnswer_Question_Question_ID"
  # add_foreign_key "question_content", "question_segment", column: "Question_Segment_ID", primary_key: "Question_Segment_ID", name: "FK_QuestionContent_QuestionSegment_Question_Segment_ID"
  # add_foreign_key "question_group", "program", column: "Program_ID", primary_key: "ID", name: "FK_QuestionGroup_Program_ID"
  # add_foreign_key "question_segment", "question", column: "Question_ID", primary_key: "Question_ID", name: "FK_QuestionSegment_Question_Question_ID"
  # add_foreign_key "question_segment", "question_segment_type", column: "Question_Segment_Type_ID", primary_key: "Question_Segment_Type_ID", name: "FK_QustnSgmnt_QustnSgmntType_Question_Sement_Type_ID"
  # add_foreign_key "questiongroup", "partnership", column: "Partnership_ID", primary_key: "ID", name: "questiongroup_ibfk_1"
  # add_foreign_key "questiongroupcontents", "assessmentquestion", column: "Question_ID", primary_key: "ID", name: "fk_questiongroupcontents_assessmentquestion_1"
  # add_foreign_key "questiongroupcontents", "questiongroup", column: "QuestionGroup_ID", primary_key: "ID", name: "fk_questiongroupcontents_questiongroup_1"
  # add_foreign_key "questionresource", "questionversion", column: "QuestionVersion_ID", primary_key: "ID", name: "questionresource_ibfk_1"
  # add_foreign_key "questionversion", "assessmentquestion", column: "Question_ID", primary_key: "ID", name: "questionversion_ibfk_1"
  # add_foreign_key "remoteloginrequest", "user", column: "User_ID", primary_key: "ID", name: "FK_RemoteLoginRequest_User_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "role", "role_type", column: "Role_Type_ID", primary_key: "Role_Type_ID", name: "FK_Role_RoleType_Role_Type_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "role_panel", "panel", column: "Panel_ID", primary_key: "Panel_ID", name: "FK_RolePanel_Panel_Panel_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "role_panel", "role", column: "Role_ID", primary_key: "ID", name: "FK_RolePanel_Role_Role_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "scoringthreshold", "assessment", column: "Assessment_ID", primary_key: "ID", name: "scoringthreshold_ibfk_1"
  # add_foreign_key "scoringthreshold", "questiontag", column: "Tag_ID", primary_key: "ID", name: "scoringthreshold_ibfk_3"
  # add_foreign_key "scoringthreshold", "stage", column: "Stage_ID", primary_key: "ID", name: "scoringthreshold_ibfk_2"
  # add_foreign_key "scormactivity", "scormobject", column: "scorm_object_id", primary_key: "scorm_object_id", name: "FK_ScormActivity_ScormObject"
  # add_foreign_key "scormactivity", "scormregistration", column: "scorm_registration_id", primary_key: "scorm_registration_id", name: "FK_ScormActivity_ScormRegis_1"
  # add_foreign_key "scormactivityobjective", "scormactivity", column: "scorm_activity_id", primary_key: "scorm_activity_id", name: "FK_ScormActivityObjective_S_1"
  # add_foreign_key "scormactivityrt", "scormactivity", column: "scorm_activity_id", primary_key: "scorm_activity_id", name: "FK_ScormActivityRT_ScormAct_1"
  # add_foreign_key "scormactivityrtcomment", "scormactivityrt", column: "scorm_activity_id", primary_key: "scorm_activity_id", name: "FK_ScormActivityRTComment_S_1"
  # add_foreign_key "scormactivityrtintcorrectresp", "scormactivityrtinteraction", column: "interaction_index", primary_key: "interaction_index", name: "FK_ScormActivityRTIntCorrec_1"
  # add_foreign_key "scormactivityrtintcorrectresp", "scormactivityrtinteraction", column: "scorm_activity_id", primary_key: "scorm_activity_id", name: "FK_ScormActivityRTIntCorrec_1"
  # add_foreign_key "scormactivityrtinteraction", "scormactivityrt", column: "scorm_activity_id", primary_key: "scorm_activity_id", name: "FK_ScormActivityRTInteracti_1"
  # add_foreign_key "scormactivityrtintlearnerresp", "scormactivityrtinteraction", column: "interaction_index", primary_key: "interaction_index", name: "FK_ScormActivityRTIntLearne_1"
  # add_foreign_key "scormactivityrtintlearnerresp", "scormactivityrtinteraction", column: "scorm_activity_id", primary_key: "scorm_activity_id", name: "FK_ScormActivityRTIntLearne_1"
  # add_foreign_key "scormactivityrtintobjective", "scormactivityrtinteraction", column: "interaction_index", primary_key: "interaction_index", name: "FK_ScormActivityRTIntObject_1"
  # add_foreign_key "scormactivityrtintobjective", "scormactivityrtinteraction", column: "scorm_activity_id", primary_key: "scorm_activity_id", name: "FK_ScormActivityRTIntObject_1"
  # add_foreign_key "scormactivityrtobjective", "scormactivityrt", column: "scorm_activity_id", primary_key: "scorm_activity_id", name: "FK_ScormActivityRTObjective_1"
  # add_foreign_key "scormaiccsession", "scormregistration", column: "scorm_registration_id", primary_key: "scorm_registration_id", name: "FK_ScormAiccSession_ScormRe_1"
  # add_foreign_key "scormlaunchhistory", "scormregistration", column: "scorm_registration_id", primary_key: "scorm_registration_id", name: "FK_ScormLaunchHistory_Scorm_1"
  # add_foreign_key "scormmetadata", "scormobject", column: "scorm_object_id", primary_key: "scorm_object_id", name: "FK_ScormMetadata_ScormObject"
  # add_foreign_key "scormmetadata", "scormpackage", column: "scorm_package_id", primary_key: "scorm_package_id", name: "FK_ScormMetadata_ScormPackage"
  # add_foreign_key "scormobject", "scormpackage", column: "scorm_package_id", primary_key: "scorm_package_id", name: "FK_ScormObject_ScormPackage"
  # add_foreign_key "scormobjecthierarchy", "scormobject", column: "child_scorm_object_id", primary_key: "scorm_object_id", name: "FK_ScormObjectHierarchyChil_1"
  # add_foreign_key "scormobjecthierarchy", "scormobject", column: "parent_scorm_object_id", primary_key: "scorm_object_id", name: "FK_ScormObjectHierarchyPare_1"
  # add_foreign_key "scormobjectidentifiers", "scormobject", column: "scorm_object_id", primary_key: "scorm_object_id", name: "FK_ScormObjectIdentifiers_S_1"
  # add_foreign_key "scormobjectseqdata", "scormobject", column: "scorm_object_id", primary_key: "scorm_object_id", name: "FK_ScormObjectSeqData_Scorm_1"
  # add_foreign_key "scormobjectseqobjective", "scormobjectseqdata", column: "scorm_object_id", primary_key: "scorm_object_id", name: "FK_ScormObjectSeqObjective_1"
  # add_foreign_key "scormobjectseqobjectivemap", "scormobjectseqobjective", column: "scorm_object_id", primary_key: "scorm_object_id", name: "FK_ScormObjectSeqObjectiveM_1"
  # add_foreign_key "scormobjectseqobjectivemap", "scormobjectseqobjective", column: "scorm_object_seq_objective_id", primary_key: "scorm_object_seq_objective_id", name: "FK_ScormObjectSeqObjectiveM_1"
  # add_foreign_key "scormobjectseqrolluprule", "scormobjectseqdata", column: "scorm_object_id", primary_key: "scorm_object_id", name: "FK_ScormObjectSeqRollupRule_1"
  # add_foreign_key "scormobjectseqrolluprulecond", "scormobjectseqrolluprule", column: "rollup_rule_id", primary_key: "rollup_rule_id", name: "FK_ScormObjectSeqRollupRule_2"
  # add_foreign_key "scormobjectseqrolluprulecond", "scormobjectseqrolluprule", column: "scorm_object_id", primary_key: "scorm_object_id", name: "FK_ScormObjectSeqRollupRule_2"
  # add_foreign_key "scormobjectseqrule", "scormobjectseqdata", column: "scorm_object_id", primary_key: "scorm_object_id", name: "FK_ScormObjectSeqRule_Scorm_1"
  # add_foreign_key "scormobjectseqrulecond", "scormobjectseqrule", column: "scorm_object_id", primary_key: "scorm_object_id", name: "FK_ScormObjectSeqRuleCond_S_1"
  # add_foreign_key "scormobjectseqrulecond", "scormobjectseqrule", column: "seq_rule_id", primary_key: "seq_rule_id", name: "FK_ScormObjectSeqRuleCond_S_1"
  # add_foreign_key "scormobjectshareddatamap", "scormobject", column: "scorm_object_id", primary_key: "scorm_object_id", name: "FK_ScormObjectSharedDataMap_1"
  # add_foreign_key "scormobjectsspbucket", "scormobject", column: "scorm_object_id", primary_key: "scorm_object_id", name: "FK_ScormObjectSSPBucket_Sco_1"
  # add_foreign_key "scormpackageproperties", "scormpackage", column: "scorm_package_id", primary_key: "scorm_package_id", name: "FK_ScormPackageProperties_S_1"
  # add_foreign_key "scormregistration", "scormactivity", column: "suspended_activity_id", primary_key: "scorm_activity_id", name: "FK_ScormRegistration_ScormA_1"
  # add_foreign_key "scormregistration", "scormpackage", column: "scorm_package_id", primary_key: "scorm_package_id", name: "FK_ScormRegistration_ScormP_1"
  # add_foreign_key "scormregistrationglobalobj", "scormregistration", column: "scorm_registration_id", primary_key: "scorm_registration_id", name: "FK_ScormRegistrationGlobalO_1"
  # add_foreign_key "scormregistrationshareddata", "scormregistration", column: "scorm_registration_id", primary_key: "scorm_registration_id", name: "FK_ScormRegistrationSharedD_1"
  # add_foreign_key "scormregistrationshareddata", "scormregistrationshareddataval", column: "scorm_shared_data_value_id", primary_key: "scorm_shared_data_value_id", name: "FK_ScormRegistrationSharedD_2"
  # add_foreign_key "scormregistrationshareddataval", "scormregistration", column: "scorm_registration_id", primary_key: "scorm_registration_id", name: "FK_ScormRegistrationSDVal"
  # add_foreign_key "scormregistrationsspbucket", "scormregistration", column: "scorm_registration_id", primary_key: "scorm_registration_id", name: "FK_ScormRegistrationSSPBuck_1"
  # add_foreign_key "specialty", "trainingfield", column: "TrainingField_ID", primary_key: "ID", name: "FK_Specialty_TrainingField_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "stageaccess", "stage", column: "Stage_ID", primary_key: "ID", name: "stageaccess_ibfk_1"
  # add_foreign_key "stagecontents", "questiongroup", column: "Group_ID", primary_key: "ID", name: "stagecontents_ibfk_2"
  # add_foreign_key "stagecontents", "stage", column: "Stage_ID", primary_key: "ID", name: "stagecontents_ibfk_1"
  # add_foreign_key "state", "country", column: "Country_ID", primary_key: "ID", name: "FK_State_Country_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "statesalestax", "state", column: "State_ID", primary_key: "ID", name: "FK_State_ID"
  # add_foreign_key "student_message", "user", column: "Creator_User_ID", primary_key: "ID", name: "FK_User_StudentMessage", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "systemannouncement", "announcement", column: "Announcement_ID", primary_key: "ID", name: "FK_SystemAnnouncement_Announcement_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "threshold", "gradecolor", column: "GradeColor_ID", primary_key: "ID", name: "FK_Threshold_GradeColor_ID", on_update: :cascade
  # add_foreign_key "threshold", "gradegraphic", column: "GradeGraphic_ID", primary_key: "ID", name: "FK_Threshold_GradeGraphic_ID", on_update: :cascade
  # add_foreign_key "threshold", "gradename", column: "GradeName_ID", primary_key: "ID", name: "FK_Threshold_GradeName_ID", on_update: :cascade
  # add_foreign_key "thresholdcollectioncontents", "activity", column: "Activity_ID", primary_key: "ID", name: "FK_ThresholdCollectionContents_Activity_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "thresholdcollectioncontents", "recordingtype", column: "RecordingType_ID", primary_key: "ID", name: "FK_ThresholdCollectionContents_RecordingType_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "thresholdcollectioncontents", "thresholdcollection", column: "ThresholdCollection_ID", primary_key: "ID", name: "FK_ThresholdCollectionContents_ThresholdCollection_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "thresholdcollectioncontents", "thresholdset", column: "ThresholdSet_ID", primary_key: "ID", name: "FK_ThresholdCollectionContents_ThresholdSet_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "thresholdsetcontents", "threshold", column: "Threshold_ID", primary_key: "ID", name: "FK_ThresholdSetContents_Threshold_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "thresholdsetcontents", "thresholdset", column: "ThresholdSet_ID", primary_key: "ID", name: "FK_ThresholdSetContents_ThresholdSet_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "tincanactivityprovider", "tincanappid", column: "app_id", name: "FK_TinCanActivityProvider_1"
  # add_foreign_key "tincanactivityprovidermap", "tincanactivityprovider", column: "app_id", primary_key: "app_id", name: "FK_TinCanActivityProviderMap_2"
  # add_foreign_key "tincanactivityprovidermap", "tincanactivityprovider", column: "provider_id", primary_key: "provider_id", name: "FK_TinCanActivityProviderMap_2"
  # add_foreign_key "tincanactivityprovidermap", "tincanappid", column: "app_id", name: "FK_TinCanActivityProviderMap_1"
  # add_foreign_key "tincanactorproperties", "tincanappid", column: "app_id", name: "FK_TinCanActorProperties_1"
  # add_foreign_key "tincanagent", "tincanappid", column: "app_id", name: "FK_TinCanAgent_1"
  # add_foreign_key "tincanagent", "tincanstatementindex", column: "app_id", primary_key: "app_id", name: "FK_TinCanAgent_2"
  # add_foreign_key "tincanagent", "tincanstatementindex", column: "statement_id", primary_key: "statement_id", name: "FK_TinCanAgent_2"
  # add_foreign_key "tincancontextactivity", "tincanappid", column: "app_id", name: "FK_TinCanContextActivity_1"
  # add_foreign_key "tincancontextactivity", "tincanstatementindex", column: "app_id", primary_key: "app_id", name: "FK_TinCanContextActivity_2"
  # add_foreign_key "tincancontextactivity", "tincanstatementindex", column: "statement_id", primary_key: "statement_id", name: "FK_TinCanContextActivity_2"
  # add_foreign_key "tincandocuments", "tincanappid", column: "app_id", name: "FK_TinCanDocuments_1"
  # add_foreign_key "tincanpackage", "scormpackage", column: "scorm_package_id", primary_key: "scorm_package_id", name: "FK_TinCanPackage_1"
  # add_foreign_key "tincanpermissions", "tincanappid", column: "app_id", name: "FK_TinCanPermissions_1"
  # add_foreign_key "tincanregistration", "scormregistration", column: "scorm_registration_id", primary_key: "scorm_registration_id", name: "FK_TinCanRegistration_1"
  # add_foreign_key "tincanrelatedactivity", "tincanappid", column: "app_id", name: "FK_TinCanRelatedActivity_1"
  # add_foreign_key "tincanrelatedactivity", "tincanstatementindex", column: "app_id", primary_key: "app_id", name: "FK_TinCanRelatedActivity_2"
  # add_foreign_key "tincanrelatedactivity", "tincanstatementindex", column: "statement_id", primary_key: "statement_id", name: "FK_TinCanRelatedActivity_2"
  # add_foreign_key "tincanrelatedagent", "tincanappid", column: "app_id", name: "FK_TinCanRelatedAgent_1"
  # add_foreign_key "tincanrelatedagent", "tincanstatementindex", column: "app_id", primary_key: "app_id", name: "FK_TinCanRelatedAgent_2"
  # add_foreign_key "tincanrelatedagent", "tincanstatementindex", column: "statement_id", primary_key: "statement_id", name: "FK_TinCanRelatedAgent_2"
  # add_foreign_key "tincansandboxappids", "tincanappid", column: "app_id", name: "FK_TinCanSandboxAppIds_1"
  # add_foreign_key "tincansandboxappids", "tincanappid", column: "sandbox_app_id", name: "FK_TinCanSandboxAppIds_2"
  # add_foreign_key "tincanstatementindex", "tincanappid", column: "app_id", name: "FK_TinCanStatementIndex_1"
  # add_foreign_key "tincantargetstatement", "tincanappid", column: "app_id", name: "FK_TinCanTargetStatement_1"
  # add_foreign_key "trainingfieldcertificateflag", "certificateflag", column: "CertificateFlag_ID", primary_key: "ID", name: "FK_TrainingFieldCertificateFlag_CertificateFlag_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "trainingfieldcertificateflag", "trainingfield", column: "TrainingField_ID", primary_key: "ID", name: "FK_TrainingFieldCertificateFlag_TrainingField_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "trainingfieldemploymentflag", "employmentflag", column: "EmploymentFlag_ID", primary_key: "ID", name: "FK_TrainingFieldEmploymentFlag_EmploymentFlag_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "trainingfieldemploymentflag", "trainingfield", column: "TrainingField_ID", primary_key: "ID", name: "FK_TrainingFieldEmploymentFlag_TrainingField_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "transcriptionsave", "enrollment", column: "Enrollment_ID", primary_key: "ID", name: "FK_TranscriptionSave_Enrollment_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "transcriptionsave", "page", column: "Page_ID", primary_key: "ID", name: "FK_TranscriptionSave_Page_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "unitversion", "unit", column: "Unit_ID", primary_key: "ID", name: "FK_UnitVersion_Unit_ID", on_update: :cascade
  # add_foreign_key "unitversioncontents", "page", column: "Page_ID", primary_key: "ID", name: "FK_UnitVersionContents_Page_ID", on_update: :cascade
  # add_foreign_key "unitversioncontents", "unitversion", column: "UnitVersion_ID", primary_key: "ID", name: "FK_UnitVersionContents_UnitVersion_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "unitversioncontentsbranding", "programbranding", column: "ProgramBranding_ID", primary_key: "ID", name: "FK_UnitVersionContentsBranding_ProgramBranding_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "unitversioncontentsbranding", "recordingtype", column: "RecordingType_ID", primary_key: "ID", name: "FK_UnitVersionContentsBranding_RecordingType_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "unitversioncontentsbranding", "unitversioncontents", column: "UnitVersionContents_ID", primary_key: "ID", name: "FK_UnitVersionContentsBranding_UnitVersionContents_ID", on_update: :cascade, on_delete: :cascade
  add_foreign_key "user", "individual", column: "Individual_Contact_ID", primary_key: "Contact_ID", name: "FK_User_Individual_Contact_ID", on_update: :cascade, on_delete: :cascade
  add_foreign_key "user", "organization", column: "BelongsToOrganization_ID", primary_key: "Contact_ID", name: "FK_User_BelongsToOrganization_ID", on_update: :cascade
  add_foreign_key "user", "organization", column: "ToolScopeOrganization_ID", primary_key: "Contact_ID", name: "FK_User_ToolScopeOrganization_ID", on_update: :cascade
##  add_foreign_key "user", "trainingfield", column: "ToolScopeTrainingField_ID", primary_key: "ID", name: "FK_User_ToolScopeTrainingField_ID", on_update: :cascade
  # add_foreign_key "user_message_group", "message_group", column: "Message_Group_ID", primary_key: "Message_Group_ID", name: "FK_MessageGroup_UserMessageGroup", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "user_message_group", "user", column: "User_ID", primary_key: "ID", name: "FK_User_UserMessageGroup", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "user_student_message", "student_message", column: "Student_Message_ID", primary_key: "Student_Message_ID", name: "FK_StudentMessage_UserStudentMessage", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "user_student_message", "user", column: "User_ID", primary_key: "ID", name: "FK_User_UserStudent_Message", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "usermessageattachment", "usermessage", column: "UserMessage_ID", primary_key: "ID", name: "FK_UserMessageAttachment_UserMessage_ID", on_update: :cascade, on_delete: :cascade
  # add_foreign_key "userpartnershiprole", "role", column: "Role_ID", primary_key: "ID", name: "FK_UserPartnershipRole_Role_ID", on_update: :cascade
  # add_foreign_key "userpartnershiprole", "user", column: "User_ID", primary_key: "ID", name: "FK_UserPartnershipRole_User_ID", on_update: :cascade, on_delete: :cascade
end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_02_01_021214) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pg_stat_statements"
  enable_extension "uuid-ossp"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "accesslevel", ["ADMIN", "EDITOR", "VIEWER"]
  create_enum "activationstatus", ["ON", "OFF"]
  create_enum "agent", ["home-loan", "sales", "hr", "cc", "acrm-support", "general", "sales-swaminarayan", "acp"]
  create_enum "appmode", ["B2B", "B2C"]
  create_enum "bookingstatus", ["ACTIVE", "CANCELLED", "INACTIVE", "AUTO_APPROVED"]
  create_enum "campaignmethod", ["API", "CRON", "CALL"]
  create_enum "category", ["Tool", "AIModel", "DocumentType", "FileUploadType", "charts", "table", "cards", "filters", "response", "Chart", "Table", "Card", "Filter", "Response", "ExotelSubDomain", "Miscellaneous", "prompt", "Prompt"]
  create_enum "conversationaction", ["HIDE", "DELETE"]
  create_enum "conversationentitytype", ["FB_PAGE", "INSTAGRAM_ACCOUNT", "GMB_LOCATION"]
  create_enum "conversationstatus", ["conversation_fetch_error", "received", "entity_not_integrated", "sentiment_analysis_error", "hidden", "deleted", "perform_action_on_negative_conversation_error", "reply_generated", "generate_reply_error", "replied", "reply_error", "extract_leads_error", "save_leads_error"]
  create_enum "conversationtype", ["COMMENT", "MESSAGE", "REVIEW", "QUESTION"]
  create_enum "conversationwebhooksource", ["meta", "gmb"]
  create_enum "dripfrequency", ["WEEKLY", "DAILY", "HOURLY", "MONTHLY"]
  create_enum "driptriggeridentifier", ["SV_DONE", "FRESH_LEAD_CREATED"]
  create_enum "eventstatus", ["New", "Cancelled", "Done", "Failed", "Unassigned", "Rescheduled", "Missed", "NoActivity", "CPMeetingDone", "LeadSVDone", "LeadBookingDone", "NotInterested"]
  create_enum "eventtype", ["sv", "f2f", "followup", "Rescheduled", "Missed"]
  create_enum "exotelsubdomain", ["api.exotel.com", "api.in.exotel.com"]
  create_enum "feedbackstatus", ["ACTIVE", "EDITED"]
  create_enum "feedbacktype", ["THUMBSUP", "THUMBSDOWN"]
  create_enum "gender_enum", ["male", "female"]
  create_enum "genie_analytics_source_enum", ["dashboard", "agent_app", "genie"]
  create_enum "gmbconversationtype", ["QUESTION", "REVIEW"]
  create_enum "gmbconversationupdatetype", ["NEW_QUESTION", "UPDATED_QUESTION", "NEW_REVIEW", "UPDATED_REVIEW"]
  create_enum "lead_status_enum", ["New", "Junk", "In transfer", "In Call Center", "Fresh", "Claimed", "Interested", "Meeting done", "Visit done", "Final negotiation", "Booking done", "Failed", "Linked"]
  create_enum "messagesource", ["WEB", "WHATSAPP", "SD", "APP", "CALL", "IG_COMMENT", "IG_DM", "FB_COMMENT", "FB_DM", "GOOGLE_REVIEW", "OUTBOUND_CALL", "INBOUND_CALL"]
  create_enum "messagestatus", ["ACTIVE", "EDITED"]
  create_enum "messagetype", ["USER_MESSAGE", "GENIE_REPLY", "AGENT_REPLY", "GENIE_PROMPT", "CALL_RECORDING"]
  create_enum "metaplatformtype", ["FACEBOOK", "INSTAGRAM"]
  create_enum "mode", ["LIVE", "DRAFT", "TEST"]
  create_enum "pinvalue", ["PINNED", "UNPINNED"]
  create_enum "placement", ["vdnb", "junk", "failed", "all_minus_booking", "wip", "failed_after_visit", "all_cps", "other", "active_cps"]
  create_enum "qualificationreason", ["CP_LEAD", "SV_EVENT", "MESSAGE_COUNT", "OFF_HOURS", "CALL_ATTEMPTS", "JNF", "WHATSAPP_INBOUND", "META_INBOUND"]
  create_enum "replykeywordtype", ["WHITELISTED", "BLACKLISTED"]
  create_enum "scheduled_status_enum", ["done", "scheduled", "dnd_messages", "cancelled", "edited"]
  create_enum "scheduled_task_enum", ["call", "drip", "dnd_messages"]
  create_enum "scheduledstatusenum", ["done", "scheduled", "cancelled"]
  create_enum "scheduledtaskenum", ["drip", "call"]
  create_enum "sessionstatus", ["ACTIVE", "ENDED", "DELETED", "STOPPED"]
  create_enum "sessiontype", ["STATS", "DEFAULT", "TEST"]
  create_enum "templatetype", ["TEXT", "IMAGE", "VIDEO", "DOCUMENT"]
  create_enum "usertype", ["LEAD", "EMPLOYEE", "CP", "DEFAULT", "DUMMY", "ACP", "APPLICANT", "MARKETING"]
  create_enum "usertype_old", ["LEAD", "EMPLOYEE", "CP", "DEFAULT", "DUMMY", "ACP", "APPLICANT", "MARKETING"]
  create_enum "whatsapp_provider_enum", ["WATI", "GUPSHUP", "MKONNECT", "EXOTEL"]
  create_enum "whatsappmessagestatus", ["SENT", "DELIVERED", "READ", "FAILED", "NEW", "REPLIED"]

  create_table "access_level", id: :integer, default: -> { "nextval('access_level_temp_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "email", null: false
    t.integer "agent_id"
    t.enum "access", default: "EDITOR", enum_type: "accesslevel"
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }
    t.timestamptz "updated_at", default: -> { "CURRENT_TIMESTAMP" }
    t.boolean "is_deleted", default: false

    t.unique_constraint ["agent_id", "email"], name: "uix_agent_id_email"
  end

  create_table "agents", id: :serial, force: :cascade do |t|
    t.string "bot_name", null: false, comment: "Name of agent"
    t.string "character_name", null: false, comment: "Name of bot"
    t.string "assignments", default: [], comment: "Assignment ids associated with given agent with asem mapping in assignment_project_mapping table", array: true
    t.string "assignments_name", default: [], comment: "Name of assignments associated with given agent", array: true
    t.string "system_prompts_dos", default: [], array: true
    t.string "system_prompts_donts", default: [], array: true
    t.enum "gender", default: "female", null: false, enum_type: "gender_enum"
    t.string "photo"
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }
    t.timestamptz "updated_at", default: -> { "CURRENT_TIMESTAMP" }
    t.enum "whatsapp_provider", enum_type: "whatsapp_provider_enum"
    t.string "emails", default: [], comment: "Emails of admin to be cc for given agent", array: true
    t.integer "model"
    t.enum "mode", default: "DRAFT", null: false, enum_type: "mode"
    t.json "meta_data", default: {}
    t.enum "user_types", default: [], array: true, enum_type: "usertype"
    t.string "additional_dos_donts"
    t.json "prompt_meta_data", default: {}
    t.index "lower((bot_name)::text)", name: "bot_name_unique_idx", unique: true
  end

  create_table "agents_replica", id: false, force: :cascade do |t|
    t.integer "id"
    t.string "bot_name"
    t.string "character_name"
    t.string "assignments", array: true
    t.string "assignments_name", array: true
    t.string "system_prompts_dos", array: true
    t.string "system_prompts_donts", array: true
    t.enum "gender", enum_type: "gender_enum"
    t.string "photo"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.enum "whatsapp_provider", enum_type: "whatsapp_provider_enum"
    t.string "emails", array: true
    t.integer "model"
    t.enum "mode", enum_type: "mode"
    t.json "meta_data"
    t.enum "user_types", array: true, enum_type: "usertype"
  end

  create_table "alembic_version", primary_key: "version_num", id: { type: :string, limit: 32 }, force: :cascade do |t|
  end

  create_table "bookings", id: :serial, force: :cascade do |t|
    t.uuid "user_id"
    t.integer "booking_id"
    t.datetime "booking_time", precision: nil
    t.enum "booking_status", null: false, enum_type: "bookingstatus"
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "agent_id"
    t.enum "reasons", array: true, enum_type: "qualificationreason"
    t.enum "top_reason", enum_type: "qualificationreason"
    t.integer "lead_id"
    t.enum "lead_status", enum_type: "lead_status_enum"
    t.uuid "campaign_id"
    t.index ["booking_id"], name: "ix_bookings_booking_id"
  end

  create_table "calls", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "call_sid", null: false
    t.uuid "user_id", null: false
    t.string "anarock_employee_id"
    t.boolean "user_answered", default: false, null: false, comment: "Calls that are answered by the call receivers - generally reffered as leads"
    t.boolean "anarock_employee_answered", default: false, null: false, comment: "Calls that are answered by the call dailers generally reffered as agents"
    t.integer "duration", comment: "duration of call"
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "agent_id"
    t.integer "attempts", default: 1
    t.text "recording"
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.boolean "ai_call", default: false
    t.uuid "campaign_id"
    t.string "notes"
    t.index ["call_sid"], name: "ix_call_sid"
  end

  create_table "campaigns", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.enum "target_audience", enum_type: "usertype"
    t.enum "campaign_method", enum_type: "campaignmethod"
    t.string "broadcast_name"
    t.datetime "schedule_time", precision: nil
    t.string "csv_s3_link"
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.integer "agent_id"
    t.string "template_name"
    t.integer "receiver_count"
    t.uuid "scheduled_by"
    t.enum "placement", default: [], array: true, enum_type: "placement"
    t.string "error_csv_s3_link"
    t.integer "error_receiver_count"
    t.integer "project_id"
    t.json "meta_data", default: {}
    t.index ["campaign_method", "agent_id"], name: "ix_campaign_method_agent_id"
  end

  create_table "conversation_webhooks", id: :serial, force: :cascade do |t|
    t.enum "webhook_source", null: false, enum_type: "conversationwebhooksource"
    t.json "conversation_data", null: false
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
  end

  create_table "cp_configs", force: :cascade do |t|
    t.integer "channel_partner_id", null: false
    t.string "campaign_id", null: false
    t.integer "project_id", null: false
    t.string "project_name", null: false
    t.string "link", null: false
    t.string "phone", null: false
  end

  create_table "cp_leads", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.integer "anarock_id", null: false
    t.uuid "user_id", null: false
    t.integer "agent_id", null: false
    t.integer "project_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }

    t.unique_constraint ["anarock_id", "user_id", "project_id"], name: "uq_cp_leads_anarock_id_user_id_project_id"
  end

  create_table "cp_pages_hal9000", id: :serial, force: :cascade do |t|
    t.integer "cp_id", null: false
    t.string "page_id", limit: 255, null: false
  end

  create_table "cp_users_hal9000", id: :serial, force: :cascade do |t|
    t.text "user_token", null: false
    t.integer "cp_id", null: false
  end

  create_table "documents", id: :serial, force: :cascade do |t|
    t.integer "agent_id"
    t.string "link"
    t.timestamptz "start_date", default: -> { "CURRENT_TIMESTAMP" }
    t.timestamptz "end_date"
    t.boolean "status", default: true, null: false
    t.json "meta_data"
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }
    t.timestamptz "updated_at", default: -> { "CURRENT_TIMESTAMP" }
    t.integer "document"
    t.boolean "is_deleted", default: false, null: false
    t.index ["agent_id", "is_deleted"], name: "ix_documents_agent_id_is_deleted"
    t.index ["agent_id"], name: "ix_documents_agent_id"
  end

  create_table "documents_replica", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "agent_id"
    t.string "link"
    t.timestamptz "start_date"
    t.timestamptz "end_date"
    t.boolean "status"
    t.json "meta_data"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.integer "document"
    t.boolean "is_deleted"
  end

  create_table "drip_marketing", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "message_id"
    t.string "template_name", comment: "Whatsapp providers unique template name"
    t.string "category", comment: "Type of template message triggered"
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "agent_id"
    t.uuid "user_id"
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.string "whatsapp_message_id"
    t.enum "message_status", default: "NEW", comment: "Current template message status triggered to a user", enum_type: "whatsappmessagestatus"
    t.uuid "campaign_id"
    t.enum "lead_status", enum_type: "lead_status_enum"
    t.integer "retry_count", limit: 2, default: 0
    t.json "meta_data", default: {}
    t.index ["template_name"], name: "ix_drip_marketing_template_name"
    t.index ["updated_at"], name: "drip_marketing_updated_at_idx"
    t.index ["whatsapp_message_id"], name: "idx_whatsapp_message_id"
  end

  create_table "drip_marketing_failed_reasons", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "drip_marketing_id", null: false
    t.string "whatsapp_message_id"
    t.string "reason"
    t.datetime "created_at", precision: nil, default: -> { "now()" }
    t.index ["drip_marketing_id"], name: "idx_failed_reasons_drip_marketing_id"
    t.index ["reason"], name: "idx_reason"
    t.index ["whatsapp_message_id"], name: "idx_failed_reasons_whatsapp_message_id"
  end

  create_table "drip_marketing_test", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "message_id"
    t.string "template_name", comment: "Whatsapp providers unique template name"
    t.string "category", comment: "Type of template message triggered"
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "agent_id"
    t.uuid "user_id"
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.string "whatsapp_message_id"
    t.enum "message_status", default: "NEW", comment: "Current template message status triggered to a user", enum_type: "whatsappmessagestatus"
    t.uuid "campaign_id"
    t.index ["whatsapp_message_id"], name: "drip_marketing_test_whatsapp_message_id_idx"
  end

  create_table "drip_marketing_triggers", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.bigint "agent_id"
    t.enum "frequency", enum_type: "dripfrequency"
    t.string "filters"
    t.string "trigger_time"
    t.datetime "start_date", precision: nil
    t.datetime "end_date", precision: nil
    t.string "start_time"
    t.string "end_time"
    t.string "description"
    t.boolean "active_status", default: false, null: false
    t.string "sql_query"
    t.string "template_message"
    t.string "template_name"
    t.string "broadcast_name"
    t.string "variable_names", default: [], array: true
    t.enum "target_audience", enum_type: "usertype"
    t.string "inactive_reason"
    t.enum "drip_trigger_identifier", enum_type: "driptriggeridentifier"
    t.index ["agent_id"], name: "ix_drip_marketing_triggers_agent_id"
    t.index ["template_name"], name: "ix_drip_marketing_triggers_template_name"
  end

  create_table "drip_media", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string "template_name"
    t.integer "agent_id"
    t.string "media_link"
    t.enum "template_type", enum_type: "templatetype"
    t.string "media_identifier"
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "template_last_updated_at", precision: nil

    t.unique_constraint ["agent_id", "template_name"], name: "uq_agent_id_template_name"
  end

  create_table "entity_conversation_integrations", id: :serial, force: :cascade do |t|
    t.enum "entity_type", null: false, enum_type: "conversationentitytype"
    t.string "entity_id", limit: 255, null: false
    t.enum "conversation_type", null: false, enum_type: "conversationtype"
    t.integer "assignment_id"
    t.integer "project_id"
    t.integer "agent_id", null: false
    t.enum "status", null: false, enum_type: "activationstatus"
    t.enum "action", null: false, enum_type: "conversationaction"
    t.string "campaign_id", limit: 255
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false

    t.unique_constraint ["entity_type", "entity_id", "conversation_type"], name: "uix_entity_type_entity_id_conversation_type"
  end

  create_table "events", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.integer "event_id"
    t.enum "event_type", null: false, enum_type: "eventtype"
    t.datetime "event_start_time", precision: nil
    t.datetime "event_end_time", precision: nil
    t.enum "status", null: false, enum_type: "eventstatus"
    t.string "anarock_id"
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil
    t.integer "agent_id"
    t.boolean "assisted", default: true
    t.enum "reasons", array: true, enum_type: "qualificationreason"
    t.enum "top_reason", enum_type: "qualificationreason"
    t.enum "lead_status", enum_type: "lead_status_enum"
    t.boolean "cp_event"
    t.integer "project_id"
    t.uuid "campaign_id"
  end

  create_table "exotel_credentials", id: :serial, force: :cascade do |t|
    t.integer "agent_id", null: false
    t.string "encrypted_api_key", null: false
    t.string "encrypted_api_token", null: false
    t.enum "subdomain", null: false, enum_type: "exotelsubdomain"
    t.string "encrypted_sid", null: false
    t.string "phone_number", null: false
    t.string "encrypted_waba_id", null: false
    t.index ["agent_id"], name: "ix_exotel_credentials_agent_id"
    t.index ["phone_number"], name: "ix_exotel_credentials_phone_number"
  end

  create_table "fb_apps", id: :serial, force: :cascade do |t|
    t.string "app_id", limit: 255, null: false
    t.string "app_secret", null: false
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false

    t.unique_constraint ["app_id"], name: "fb_apps_app_id_key"
  end

  create_table "fb_comments", id: :serial, force: :cascade do |t|
    t.string "user_id", limit: 255, null: false
    t.text "content", null: false
    t.enum "status", null: false, enum_type: "conversationstatus"
    t.integer "integration_id"
    t.boolean "is_appropriate"
    t.text "reply"
    t.integer "lead_ids", array: true
    t.datetime "published_at", precision: nil, null: false
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "parent_id", limit: 255
    t.string "user_name", limit: 255, null: false
    t.string "comment_id", limit: 255, null: false
    t.string "post_id", limit: 255

    t.unique_constraint ["comment_id", "parent_id"], name: "uix_comment_id_parent_id"
  end

  create_table "fb_page_instagram_account_mappings", id: :serial, force: :cascade do |t|
    t.string "fb_page_id", limit: 255, null: false
    t.string "instagram_account_id", limit: 255, null: false
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false

    t.unique_constraint ["fb_page_id"], name: "fb_page_instagram_account_mappings_fb_page_id_key"
    t.unique_constraint ["instagram_account_id"], name: "fb_page_instagram_account_mappings_instagram_account_id_key"
  end

  create_table "fb_pages", id: :serial, force: :cascade do |t|
    t.string "page_id", limit: 255, null: false
    t.string "page_name", limit: 255, null: false
    t.enum "status", null: false, enum_type: "activationstatus"
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false

    t.unique_constraint ["page_id"], name: "fb_pages_page_id_key"
  end

  create_table "fb_pages_hal9000", id: :serial, force: :cascade do |t|
    t.string "page_id", limit: 255, null: false
    t.string "page_name", limit: 255, null: false
    t.text "page_token", null: false
  end

  create_table "fb_user_page_mappings", id: :serial, force: :cascade do |t|
    t.integer "page_id", null: false
    t.integer "user_id", null: false
    t.string "page_token"
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false

    t.unique_constraint ["page_id", "user_id"], name: "uix_page_id_fb_user_id"
  end

  create_table "fb_users", id: :serial, force: :cascade do |t|
    t.string "profile_id", limit: 255
    t.integer "developer_id"
    t.string "access_token"
    t.string "name", limit: 255
    t.string "email", limit: 255
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false

    t.unique_constraint ["developer_id", "profile_id"], name: "uix_developer_id_profile_id"
  end

  create_table "feedbacks", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid "session_id", null: false
    t.uuid "message_id", null: false
    t.uuid "user_id", null: false
    t.enum "status", default: "ACTIVE", null: false, enum_type: "feedbackstatus"
    t.string "notes"
    t.enum "type", null: false, enum_type: "feedbacktype"
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at", precision: nil
  end

  create_table "gcp_projects", id: :serial, force: :cascade do |t|
    t.string "project_id", limit: 255, null: false
    t.string "client_id", null: false
    t.string "client_secret", null: false
    t.string "auth_provider_x509_cert_url", limit: 255, null: false
    t.string "auth_uri", limit: 255, null: false
    t.string "token_uri", limit: 255, null: false
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false

    t.unique_constraint ["project_id"], name: "gcp_projects_project_id_key"
  end

  create_table "genie_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.integer "agent_id"
    t.integer "project_id"
    t.string "phone_number"
    t.string "country_code"
    t.string "budget"
    t.string "config", array: true
    t.string "purpose"
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }
    t.timestamptz "updated_at", default: -> { "CURRENT_TIMESTAMP" }
    t.index ["phone_number", "user_id", "agent_id"], name: "unique_user_phone_user_id_agent_project_null", unique: true, where: "(project_id IS NULL)"
    t.index ["user_id", "phone_number"], name: "ix_genie_users_user_id_phone_number"
  end

  create_table "genie_users_analytics", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.datetime "session_start_time", precision: nil, null: false
    t.datetime "session_end_time", precision: nil
    t.enum "source", null: false, enum_type: "genie_analytics_source_enum"
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
  end

  create_table "gmb_account_developer_mappings", id: :serial, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "developer_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false

    t.unique_constraint ["account_id", "developer_id"], name: "uix_account_id_developer_id"
  end

  create_table "gmb_account_location_mappings", id: :serial, force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "location_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false

    t.unique_constraint ["account_id", "location_id"], name: "uix_account_id_location_id"
  end

  create_table "gmb_accounts", id: :serial, force: :cascade do |t|
    t.string "account_id", limit: 255, null: false
    t.string "name", limit: 255, null: false
    t.text "token", null: false
    t.text "refresh_token", null: false
    t.integer "gcp_project_id", null: false
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false

    t.unique_constraint ["account_id"], name: "gmb_accounts_account_id_key"
  end

  create_table "gmb_conversations", id: :serial, force: :cascade do |t|
    t.string "conversation_id", limit: 255, null: false
    t.string "location_id", limit: 255, null: false
    t.string "account_id", limit: 255, null: false
    t.text "content"
    t.string "user_name", limit: 255
    t.enum "conversation_type", null: false, enum_type: "gmbconversationtype"
    t.enum "conversation_update_type", null: false, enum_type: "gmbconversationupdatetype"
    t.integer "integration_id"
    t.boolean "is_appropriate"
    t.enum "status", null: false, enum_type: "conversationstatus"
    t.text "reply"
    t.integer "lead_ids", array: true
    t.datetime "published_at", precision: nil
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false

    t.unique_constraint ["conversation_id", "conversation_type", "conversation_update_type"], name: "uix_conversation_id_conversation_type_conversation_update_type"
  end

  create_table "gmb_locations", id: :serial, force: :cascade do |t|
    t.string "location_id", limit: 255, null: false
    t.string "name", limit: 255, null: false
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false

    t.unique_constraint ["location_id"], name: "gmb_locations_location_id_key"
  end

  create_table "gupshup_credentials", id: :serial, force: :cascade do |t|
    t.integer "agent_id", null: false
    t.string "encrypted_api_key", null: false
    t.string "phone_number", null: false
    t.string "srcname", null: false

    t.unique_constraint ["agent_id"], name: "gupshup_credentials_agent_id_key"
  end

  create_table "instagram_comments", id: :serial, force: :cascade do |t|
    t.string "user_id", limit: 255, null: false
    t.text "content", null: false
    t.enum "status", null: false, enum_type: "conversationstatus"
    t.integer "integration_id"
    t.boolean "is_appropriate"
    t.text "reply"
    t.integer "lead_ids", array: true
    t.timestamptz "published_at", null: false
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "parent_id", limit: 255
    t.string "user_name", limit: 255, null: false
    t.string "comment_id", limit: 255, null: false
    t.string "media_id", limit: 255
    t.string "media_type", limit: 255

    t.unique_constraint ["comment_id"], name: "instagram_comments_comment_id_key"
  end

  create_table "keyword_actions", id: :serial, force: :cascade do |t|
    t.integer "agent_id", null: false
    t.string "keyword", limit: 255, null: false
    t.enum "action_type", null: false, enum_type: "replykeywordtype"
    t.string "action_by_user", limit: 255, null: false
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at", precision: nil
    t.index ["agent_id", "keyword"], name: "ix_keyword_actions_agent_id_keyword"
  end

  create_table "lead_statuses", id: :serial, force: :cascade do |t|
    t.string "lead_id", null: false
    t.enum "lead_creation_status", null: false, enum_type: "lead_status_enum"
    t.enum "current_status", null: false, enum_type: "lead_status_enum"
    t.datetime "status_updated_at", precision: nil
    t.timestamptz "created_at", default: -> { "CURRENT_TIMESTAMP" }
    t.timestamptz "updated_at", default: -> { "CURRENT_TIMESTAMP" }
    t.index ["lead_id"], name: "ix_lead_statuses_lead_id"
    t.unique_constraint ["lead_id"], name: "lead_statuses_lead_id_key"
  end

  create_table "message_lead_status", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "message_id"
    t.enum "lead_status", null: false, enum_type: "lead_status_enum"
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
  end

  create_table "messages", id: :uuid, default: nil, force: :cascade do |t|
    t.uuid "session_id", null: false
    t.uuid "user_id", null: false
    t.enum "status", default: "ACTIVE", null: false, comment: "message status on anagrow", enum_type: "messagestatus"
    t.string "message", null: false
    t.enum "type", null: false, comment: "Type of message :\nUSER_MESSAGE - message from user\nGENIE_REPLY - LLM generated message\nAGENT_REPLY - Message sent when user messages are interuppted\nGENIE_PROMPT - Message sent while probing a user, because of his inactive behaviour", enum_type: "messagetype"
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at", precision: nil
    t.enum "app_mode", default: "B2B", null: false, enum_type: "appmode"
    t.enum "source", null: false, comment: "Source of message ", enum_type: "messagesource"
    t.uuid "interrupted_by", comment: "User id of user who has interutted the message"
    t.enum "session_type", default: "DEFAULT", enum_type: "sessiontype"
    t.json "trace_metadata", default: {}
    t.boolean "is_message_split", default: false
    t.index ["created_at"], name: "messages_created_at_idx"
    t.index ["id", "is_deleted", "app_mode"], name: "ix_messages_id_is_deleted_app_mode"
    t.index ["id", "is_deleted", "session_type"], name: "ix_messages_id_is_deleted_session_type"
    t.index ["session_id", "is_deleted", "app_mode"], name: "ix_messages_session_id_is_deleted_app_mode"
    t.index ["session_id", "is_deleted", "session_type"], name: "ix_messages_session_id_is_deleted_session_type"
    t.index ["session_id", "type"], name: "messages_idx_session_id_type"
  end

  create_table "messages_clone", id: false, force: :cascade do |t|
    t.uuid "session_id"
    t.uuid "user_id"
    t.enum "status", enum_type: "messagestatus"
    t.string "message"
    t.enum "type", enum_type: "messagetype"
    t.boolean "is_deleted"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.uuid "id"
    t.enum "app_mode", enum_type: "appmode"
    t.enum "source", enum_type: "messagesource"
    t.uuid "interrupted_by"
    t.enum "session_type", enum_type: "sessiontype"
  end

  create_table "meta_data", id: :serial, force: :cascade do |t|
    t.string "name"
    t.boolean "status", default: true
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.json "metadata_info"
    t.boolean "hide", default: true
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.enum "category", enum_type: "category"
    t.index ["name"], name: "idx_name"
  end

  create_table "meta_messages", id: :serial, force: :cascade do |t|
    t.string "user_id", limit: 255, null: false
    t.text "content", null: false
    t.enum "status", null: false, enum_type: "conversationstatus"
    t.integer "integration_id"
    t.boolean "is_appropriate"
    t.text "reply"
    t.integer "lead_ids", array: true
    t.datetime "published_at", precision: nil, null: false
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "message_id", limit: 255
    t.enum "platform_type", null: false, enum_type: "metaplatformtype"

    t.unique_constraint ["message_id", "platform_type"], name: "uix_message_id_platform_type"
    t.unique_constraint ["message_id"], name: "meta_messages_message_id_key"
  end

  create_table "mkonnect_credentials", id: :serial, force: :cascade do |t|
    t.integer "agent_id", null: false
    t.string "url", null: false
    t.string "encrypted_x_api_key", null: false
    t.string "x_wa_business_number", null: false
    t.index ["agent_id"], name: "ix_mkonnect_credentials_agent_id"
  end

  create_table "pins", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.integer "agent_id"
    t.enum "pin_value", null: false, enum_type: "pinvalue"
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.index ["user_id", "agent_id", "pin_value"], name: "ix_pins_user_id_agent_id_pin_value"
  end

  create_table "reply_sentiments", id: :serial, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "session_id"
    t.string "given_username", limit: 255
    t.text "allowed_mandates"
    t.string "extracted_username", limit: 255
    t.string "extracted_mandate_name", limit: 255
    t.text "question"
    t.text "reply"
    t.text "sentiment"
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.text "keywords", array: true
    t.index ["sentiment"], name: "idx_sentiment"
    t.index ["session_id"], name: "idx_session_id"
    t.index ["user_id"], name: "idx_user_id"
  end

  create_table "scheduled_tasks", id: false, force: :cascade do |t|
    t.enum "task_name", null: false, enum_type: "scheduled_task_enum"
    t.datetime "scheduled_at", precision: nil, null: false
    t.enum "status", null: false, enum_type: "scheduled_status_enum"
    t.json "meta_data", null: false
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.uuid "id", default: -> { "uuid_generate_v4()" }, null: false
    t.integer "agent_id"
  end

  create_table "sessions", id: { type: :uuid, comment: "unique id for a session where users can post messages", default: nil }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "title", default: "New Chat"
    t.datetime "start_timestamp", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "end_timestamp", precision: nil
    t.enum "status", default: "ACTIVE", null: false, comment: "Current sessions status where a session", enum_type: "sessionstatus"
    t.boolean "is_deleted", default: false, null: false
    t.enum "user_type", null: false, enum_type: "usertype"
    t.enum "app_mode", default: "B2B", null: false, enum_type: "appmode"
    t.boolean "stop_message", default: false, null: false, comment: "User has asked to not send messages - STOP messaging"
    t.datetime "last_messaged_date", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.boolean "interrupt_message", default: false, null: false, comment: "Boolean that indicates wether the current session of user is interupted meaning LLM is not replying but another user is replying"
    t.integer "agent_id"
    t.enum "session_type", default: "DEFAULT", enum_type: "sessiontype"
    t.index ["id", "is_deleted", "app_mode"], name: "ix_sessions_id_is_deleted_app_mode"
    t.index ["id", "is_deleted", "session_type", "agent_id"], name: "ix_sessions_id_is_deleted_session_type_agent_id"
    t.index ["id", "is_deleted", "session_type"], name: "ix_sessions_id_is_deleted_session_type"
    t.index ["last_messaged_date", "agent_id", "user_id", "interrupt_message"], name: "session_idx_last_messaged_date_agent_id_user_id_interrupt_messa"
    t.index ["user_id", "is_deleted", "app_mode"], name: "ix_sessions_user_id_is_deleted_app_mode"
    t.index ["user_id", "is_deleted", "session_type", "agent_id"], name: "ix_sessions_user_id_is_deleted_session_type_agent_id"
    t.index ["user_id", "is_deleted", "session_type"], name: "ix_sessions_user_id_is_deleted_session_type"
    t.unique_constraint ["user_id", "agent_id", "session_type", "is_deleted"], name: "uq_agent_id_user_id_session_type_is_deleted"
  end

  create_table "sessions_clone", id: false, force: :cascade do |t|
    t.uuid "user_id"
    t.string "title"
    t.datetime "start_timestamp", precision: nil
    t.datetime "end_timestamp", precision: nil
    t.enum "status", enum_type: "sessionstatus"
    t.boolean "is_deleted"
    t.uuid "id"
    t.enum "user_type", enum_type: "usertype_old"
    t.enum "app_mode", enum_type: "appmode"
    t.boolean "stop_message"
    t.datetime "last_messaged_date", precision: nil
    t.boolean "interrupt_message"
    t.integer "agent_id"
    t.enum "session_type", enum_type: "sessiontype"
  end

  create_table "test_questions", id: :serial, force: :cascade do |t|
    t.string "question"
    t.string "keywords", array: true
    t.string "answer"
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.boolean "is_locked", default: false, null: false
    t.boolean "is_deleted", default: false, null: false
    t.integer "agent_id"
    t.index ["agent_id", "is_deleted", "is_locked"], name: "ix_test_questions_agent_id_is_deleted_is_locked"
    t.index ["id", "is_deleted"], name: "ix_test_questions_id_is_deleted"
  end

  create_table "tool_details", id: :serial, force: :cascade do |t|
    t.integer "agent_id"
    t.integer "tool_id"
    t.json "meta_data", default: {}
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.boolean "is_deleted", default: false
    t.index ["agent_id", "is_deleted"], name: "ix_tool_details_agent_id_is_deleted"
    t.index ["agent_id", "tool_id"], name: "ix_tool_details_agent_id_tool_id"
    t.unique_constraint ["agent_id", "tool_id"], name: "uq_agent_id_tool_id"
  end

  create_table "urls", id: { type: :string, limit: 255 }, force: :cascade do |t|
    t.text "url", null: false
  end

  create_table "users", id: :uuid, default: nil, force: :cascade do |t|
    t.string "username", comment: "Name of user"
    t.string "email"
    t.string "phone_number"
    t.string "hashed_password"
    t.datetime "signup_date", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "last_active_date", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.boolean "is_deleted", default: false, null: false
    t.boolean "is_employee", default: false, null: false
    t.enum "user_type", null: false, enum_type: "usertype"
    t.string "anarock_id"
    t.string "country_code"
    t.string "profile_id"
    t.integer "agent_ids", default: [], array: true
    t.index ["anarock_id", "user_type", "is_deleted"], name: "ix_users_anarock_id_user_type_is_deleted"
    t.index ["anarock_id", "user_type"], name: "session_idx_anarock_id_user_type"
    t.index ["email", "user_type", "anarock_id", "is_deleted"], name: "ix_users_email_user_type_anarock_id_is_deleted"
    t.index ["id", "is_deleted"], name: "ix_users_id_is_deleted"
    t.index ["phone_number", "user_type", "anarock_id", "is_deleted"], name: "ix_users_phone_number_user_type_anarock_id_is_deleted"
    t.unique_constraint ["phone_number", "user_type", "anarock_id"], name: "uq_phone_number_user_type_anarock_id"
    t.unique_constraint ["phone_number", "user_type", "anarock_id"], name: "uq_users_phone_number_user_type_anarock_id"
  end

  create_table "wati_credentials", id: :serial, force: :cascade do |t|
    t.string "url", null: false
    t.string "encrypted_token", null: false
    t.integer "agent_id"
    t.index ["agent_id"], name: "ix_wati_credentials_agent_id"
  end

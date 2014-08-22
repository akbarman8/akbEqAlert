//
//  WFMLocalization.h
//  AxioManager
//
//  Created by Amit on 8/5/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

//----------------------------------------------------------------------------------------------------------------------
#pragma mark - UXM team Provided -
//----------------------------------------------------------------------------------------------------------------------
#define ALERT_SAVE_CHANGES                  @"Do you want to save your changes?"
#define LOC_ALERT_ERROR                     @"ERROR"
#define LOC_ALERT_INFORMATION               @"Information"
#define LOC_ALERT_WARNING                   @"Warning"

//----------------------------------------------------------------------------------------------------------------------
#pragma mark - Buttons -
//----------------------------------------------------------------------------------------------------------------------
#define LOC_BTN_CANCEL                      @"Cancel"
#define LOC_BTN_SAVE                        @"Save"
#define LOC_BTN_OK                            @"OK"
#define LOC_BTN_DELETE_ADMIN                @"Delete Administrator"
#define LOC_BTN_DELETE_ROLE                 @"Delete Role & Permission"
#define LOC_BTN_DELETE_MESSAGE              @"Delete Message"
#define LOC_BTN_DELETE_EVENT_TITLE          @"Delete Event Title"
#define LOC_BTN_DELETE_TITLE                @"Delete Title"
#define LOC_BTN_DELETE_TEMPLATE                @"Delete Template"
#define LOC_BTN_DELETE_CATEGORY             @"Delete Category"

//----------------------------------------------------------------------------------------------------------------------
#pragma mark - Progress view with indicator -
//----------------------------------------------------------------------------------------------------------------------
#define LOC_MSG_DELETING                    @"Deleting..."
#define LOC_MSG_LOADING                     @"Loading..."
#define LOC_MSG_SAVING                      @"Saving..."
#define LOC_MSG_SEARCHING                   @"Searching..."
#define LOC_MSG_VALIDATING                  @"Validating..."
#define LOC_MSG_PUBLISHING                  @"Publishing..."
#define LOC_MSG_AUTOLAYOUTING               @"AutoLayout..."
#define LOC_MSG_ADMIN_ADDING                @"Adding user..."
#define LOC_MSG_CLONING                     @"Cloning..."
#define LOC_MSG_SLA                         @"SLA Calculating..."
//----------------------------------------------------------------------------------------------------------------------
#pragma mark - App alert sheet -
//----------------------------------------------------------------------------------------------------------------------
#define LOC_FAIL_TRY_AGAIN                  @"Please try again."

#define LOC_PROCESS_LOAD_FAIL               @"Fail to load the process %@"
#define LOC_MSG_NO_AC_USER                  @"Not able to validate user %@ for Apple connect Login"
#define LOC_MSG_ROLE_EMPTY                  @"Please Enter Role Name"
#define LOC_MSG_ROLE_SPECIAL_CHAR           @"Special Characters are not allowed for role name"
#define LOC_MSG_CSDROLE_SPECIAL_CHAR        @"Special Characters are not allowed for '%@' csd role name"
#define LOC_MSG_EVENT_CSDROLE_NOSPACE       @"The Csd role name can't contain any spaces."
#define LOC_MSG_CSDROLE_SPACE               @"Space is not allowed for '%@' csd role name"
#define LOC_MSG_ROLE_MAX_CHAR               @"Role name support maximon 200 character"
#define LOC_MSG_CLONe_FAIL                  @"Fail to clone the Process"
#define LOC_MSG_CATEGORY_NO_SELECTED        @"There was no category selected."
#define LOC_PROCESS_VALIDATION_FAIL         @"Process validation fail"
#define LOC_PROCESS_SAVE_FAIL               @"Process Save fail"
#define LOC_MSG_CATEGORY_DELETE_TITLE       @"Deleting this Category removes it permanently."
#define LOC_TLE_GROUP_EMPTY                 @"A search group name is required."
#define LOC_MSG_GROUP_EMPTY                 @"Enter a search group name."
#define LOC_TLE_SERVER_DOWN                    @"The Axio server is not responding."
#define LOC_TLE_AC_LOGIN_FAIL                @"%@ user does not have access to login to Axio."
#define LOC_MSG_AC_LOGIN_FAIL               @"Get access from the application owner and try again."
#define LOC_TLE_AC_NOTSIGNIN                @"There is no user signed in."
#define LOC_MSG_AC_NOTSIGNIN                @"Sign in to proceed"
#define LOC_TLE_AC_SIGNOUT                  @"The user has signed out."
#define LOC_MSG_AC_SIGNOUT                  @"Sign in to proceed."
#define LOC_TLE_ADMIN_DELETE_TITLE          @"Deleting this administrator removes all of its associated information."
#define LOC_MSG_ADMIN_DELETE_TITLE          @"You can't undo this action."
#define LOC_TLE_ADMIN_INVALID_EMAIL         @"There is no valid email address for %@ (Person Id %@)."
#define LOC_MSG_ADMIN_INVALID_EMAIL         @"Provide a valid email address."
#define LOC_TLE_ADMIN_NOT_DELETE            @"You can't delete this administrator"
#define LOC_MSG_ADMIN_NOT_DELETE            @"You don't have the permissions to complete this action."
#define LOC_TLE_ADMIN_NO_ROLES              @"No roles were added."
#define LOC_MSG_ADMIN_NO_ROLES              @"There are no roles currently available."
#define LOC_MSG_ADMIN_NO_SELECTED           @"There was no administrator selected."
#define LOC_TLE_ADMIN_SAVE_FAIL             @"Saving the administrator failed."
#define LOC_TLE_ADMIN_SELF_ADD              @"Adding the administrator failed."
#define LOC_MSG_ADMIN_SELF_ADD              @"You can't add yourself as an administrator."
#define LOC_TLE_APP_NOACCESS                @"Access for Workflow is not allowed."
#define LOC_MSG_APP_NOACCESS                @"Get access from the application owner and try again."
#define LOC_TLE_APP_DELETE_FAIL             @"Deleting the application failed."
#define LOC_TLE_ADMIN_DELETE_FAIL           @"Deleting this admistrator failed."
#define LOC_TLE_DELETE_MESSEGE              @"Deleting this message removes all of its information."
#define LOC_MSG_DELETE_MESSEGE              @"You can't undo this action."
#define LOC_TLE_EVENT_DELETE_TITLE          @"Deleting this event title removes it permanently."
#define LOC_MSG_EVENT_DELETE_TITLE          @"You can't undo this action."
#define LOC_TLE_EVENT_EXIST                 @"Adding message failed."
#define LOC_MSG_EVENT_EXIST                 @"%@ Message already exists."
#define LOC_TLE_EVENT_NO_SELECTED           @"Deleting event failed."
#define LOC_MSG_EVENT_NO_SELECTED           @"No event selected."
#define LOC_TLE_EVENT_REC_GROUP             @"Saving the event failed."
#define LOC_MSG_EVENT_REC_GROUP             @"Message recipient group name can't be empty."
#define LOC_TLE_EVENT_REC_PERSON            @"Saving the event failed."
#define LOC_MSG_EVENT_REC_PERSON            @"Message recipient can't be empty."
#define LOC_TLE_EVENT_REC_ROLE                @"Saving the event failed."
#define LOC_MSG_EVENT_REC_ROLE              @"Message recipient can't be empty."
#define LOC_TLE_EVENT_SEND_AFTER_MUST        @"Saving the event failed."
#define LOC_MSG_EVENT_SEND_AFTER_MUST       @"Message send after time is required."
#define LOC_TLE_EVENT_SEND_AFTER_NONZERO    @"Saving the event failed."
#define LOC_MSG_EVENT_SEND_AFTER_NONZERO    @"Message send after time can't be 0."
#define LOC_TLE_EVENT_SYMBOL                @"Saving failed."
#define LOC_MSG_EVENT_SYMBOL                @"Special sybmols are not supported."
#define LOC_TLE_EVENT_TITLE_MUST            @"Saving the event failed."
#define LOC_MSG_EVENT_TITLE_MUST            @"Message title is required."
#define LOC_TLE_INVALID_SERVER                @"The server is invalid."
#define LOC_MSG_INVALID_SERVER              @"Provide a valid server."
#define LOC_MSG_NODATA                        @"No data found."
#define LOC_TLE_PERMISSION_NO                @"Access denied."
#define LOC_MSG_PERMISSION_NO               @"You don't have permission to access this."
#define LOC_TLE_ROLE_DELETE_TITLE            @"Deleting this role title removes all of its information."
#define LOC_MSG_ROLE_DELETE_TITLE           @"You can't undo this action."
#define LOC_TLE_ROLE_NO_SELECTED            @"Deleting role & permission failed."
#define LOC_MSG_ROLE_NO_SELECTED            @"There was no role & permission selected."
#define LOC_TLE_TEMPLATE_ASSOCIATED_TITLE    @"Error"
#define LOC_MSG_TEMPLATE_ASSOCIATED_TITLE   @"Templates associated with %@ %@"
#define LOC_TLE_TEMPLATE_DELETE_TITLE        @"Deleting this template removes all of its information."
#define LOC_MSG_TEMPLATE_DELETE_TITLE       @"You can't undo this action."
#define LOC_TLE_TEMPLATE_EMPTY_NAME            @"Saving template failed."
#define LOC_MSG_TEMPLATE_EMPTY_NAME         @"You must provide a process name for this template."
#define LOC_TLE_TEMPLATE_NAME_VALID            @"Saving template failed."
#define LOC_MSG_TEMPLATE_NAME_VALID         @"There are unsupported special characters in the process name. Numbers, letters, underscore, hyphen and minus are allowed."
#define LOC_TLE_TEMPLATE_NOOBJ                @"Saving template failed."
#define LOC_MSG_TEMPLATE_NOOBJ              @"There should be minimum of one object in the drawing canvas."
#define LOC_TLE_TEMPLATE_NOSPACE            @"Saving template failed."
#define LOC_MSG_TEMPLATE_NOSPACE            @"The process name can't contain any spaces."
#define LOC_TLE_TEMPLATE_NO_AVAILABLE        @"Saving template failed."
#define LOC_MSG_TEMPLATE_NO_AVAILABLE       @"There is no template available."
#define LOC_TLE_TEMPLATE_NO_SELECTED        @"Deleting template failed."
#define LOC_MSG_TEMPLATE_NO_SELECTED        @"There is no template selected."
#define LOC_TLE_TEMPLATE_PI_INVALID_SLA        @"Saving template failed."
#define LOC_MSG_TEMPLATE_PI_INVALID_SLA     @"The process input parameter is not valid to calculate MinMax SLA."
#define LOC_TLE_TEMPLATE_PN_INVALID_SLA        @"Saving template failed."
#define LOC_MSG_TEMPLATE_PN_INVALID_SLA     @"The processName input parameter is not valid to calculate MinMax SLA."
#define LOC_TLE_NO_APPLICATION                @"Saving template failed."
#define LOC_MSG_NO_APPLICATION              @"There is no application available for the User:%@ %@"
#define LOC_TLE_READ_PERMISSION                @"Saving template failed."
#define LOC_MSG_READ_PERMISSION             @"Save/Publish process permission not available for DS Id=%ld"
#define LOC_MSG_ROLE_EXIST                  @"%@ Role Name already exists."
#define LOC_TLE_DASHBOARD_DEFAULT            @"Dashboard Error."
#define LOC_MSG_DASHBOARD_DEFAULT           @"The default dashboard is not available for the selected application."
#define LOC_TLE_PROCESS_VAR_TYPE            @"The Process variable type not proper, need to select from the drop down."
#define LOC_MSG_PROCESS_VAR_TYPE            @"Error process variable type"
#define LOC_TLE_PROCESS_VAR_NAME            @"The Process variable name not proper, empty space name not supported."
#define LOC_TLE_PROCESS_VAR_NAME_EMPTY      @"The Process variable name not proper, empty name not supported."
#define LOC_MSG_PROCESS_VAR_NAME            @"Error process variable name"
#define LOC_TLE_SYSTEM_UNAVAILABLE          @"Espresso could not access the AXIO server via network. Service could be temporarily unavailable or there might be network issues. Please check your network connection and try again. If problem persists, contact IS&T Helpline."
#define LOC_MSG_SYSTEM_UNAVAILABLE          @"Unable to connect to AXIO server"
//----------------------------------------------------------------------------------------------------------------------
#pragma mark - Template related error -
//----------------------------------------------------------------------------------------------------------------------
#define LOC_TLE_TEMPLATE_ERROR              @"Template Error."
//Note: '%@' = node name
#define LOC_VALIDATION_NODEDATAINPUT_TYPE   @"Node '%@' Enter a valid standardtype for datainput"
#define LOC_VALIDATION_NODEDATAOUTPUT_TYPE  @"Node '%@' Enter a valid standardtype for dataoutput"
#define LOC_VALIDATION_NODE_ASSIGN_FROM     @"Node '%@' From Object is required."
#define LOC_VALIDATION_NODE_ASSIGN_TO       @"Node '%@' Assignment is required."
#define LOC_VALIDATION_NODE_ASSIGN_TOVAL    @"Node '%@' To value is required."
#define LOC_VALIDATION_NODE_ASSIGN_FROMOBJECT  @"Node '%@' shouldn't set output variable to from object in Assignments."
#define LOC_VALIDATION_NODE_DATAINPUT_NAME  @"Node '%@' A valid name for dataInput is required."
#define LOC_VALIDATION_NODE_DATAOUTPUT_NAME @"Node '%@' A valid name for dataoutput is required."
#define LOC_VALIDATION_NODE_EVENT_BODY      @"Node '%@' Message body can't be more than 500 characters."
#define LOC_VALIDATION_NODE_EVENT_TIME      @"Node '%@' Message Timer can't be negative value."
#define LOC_VALIDATION_NODE_EVENT_GROUP     @"Node '%@' Message recipient group details are required."
#define LOC_VALIDATION_NODE_EVENT_PERSON    @"Node '%@' Message recipient person firstname and lastname are required."
#define LOC_VALIDATION_NODE_EVENT_ROLE      @"Node '%@' Message recipient role details are required."
#define LOC_VALIDATION_NODE_EVENT_SUBJECT   @"Node '%@' Message subject can't be more than 100 characters."
#define LOC_VALIDATION_NODE_EVENT_TITLE     @"Node '%@' Message title is required and can't be more than 100 characters."
#define LOC_VALIDATION_NODE_GROUP           @"Node '%@' Recipient group details are required."
#define LOC_VALIDATION_NODE_INCOMING        @"'%@' node has multiple incoming connections, but it can only have one. Use a converging gateway (diamond) to bring connections to one or remove unnecessery connections."
#define LOC_VALIDATION_NODE_OUTGOING        @"'%@' node has multiple outgoing connections, but it can only have one. Use a diverging gateway (diamond) to fork the workflow or remove unncessary connections."
#define LOC_VALIDATION_NODE_PERSON          @"Node '%@' recipient person firstname and lastname are required."
#define LOC_VALIDATION_NODE_ROLE            @"Node '%@' recipient role details are required."
#define LOC_VALIDATION_NO_INCOMING          @"'%@' node has no incoming connection. One incoming connection is required (node has to be connected)."
#define LOC_VALIDATION_NO_OUTGOING          @"'%@' node has no outgoing connection. One outgoing connection is required (node has to be connected)."
#define LOC_VALIDATION_NO_DIVERGE_INCOMING  @"'%@' node has no incoming connection. One incoming connection is required (node has to be connected)." // added by MK
#define LOC_VALIDATION_NO_CONVERGE_OUTGOING @"'%@' node has no outgoing connection. One outgoing connection is required (node has to be connected)." // added by MK
#define LOC_VALIDATION_NO_DIVERGE_OUTGOING  @"'%@' node has no outgoing connection. At least two outgoing connections are required for a diverging gateway." // added by MK
#define LOC_VALIDATION_NO_CONVERGE_INCOMING @"'%@' node has no incoming connection. At least two incoming connections are required for a converging gateway." // added by MK

#define LOC_VALIDATION_NO_ACTOR_PERSON      @"Node '%@' has no valid actor defined for approve by person [%@ %@] of highlighted task."
#define LOC_VALIDATION_NO_ACTOR_GROUP       @"Node '%@' has no valid actor defined for approve by group [%@] of highlighted task."
#define LOC_VALIDATION_NO_ACTOR_ROLE        @"Node '%@' has no valid actor defined for approve by role [%@] of highlighted task."
#define LOC_VALIDATION_NO_ACTOR_SYSTEM      @"Node '%@' has no valid actor defined for approve by system of highlighted task."
#define LOC_VALIDATION_NO_APPROVER_TYPE     @"Node '%@' has no valid approve type defined of highlighted task."
#define LOC_VALIDATION_NO_APPROVER_ID       @"Node '%@' has no valid approve ID defined of highlighted task. It may be approver dsId or role Id based on approver type"

#define LOC_VALIDATION_DIVERGE_INCOMING     @"Diverging gateway ('%@') should have only one incoming connection but connected with multiple incoming connections. You can remove unnecessary connections."
#define LOC_VALIDATION_DIVERGE_OUTGOING     @"Diverging gateway ('%@') has just one outgoing connection, but requires at least two. If you only need one, you don't need a gateway (diamond)."
#define LOC_VALIDATION_DIVERGE_INCOMING_NO  @"Diverging gateway ('%@') has no incoming connections. You have to use only one incoming connection."
#define LOC_VALIDATION_DIVERGE_OUTGOING_NO  @"Diverging gateway ('%@') has no outgoing connections, but requires at least two."

#define LOC_VALIDATION_CONVERGE_INCOMING    @"Converging gateway ('%@') has just one incoming connection, but expects at least two. If you only need one, you don't need a gateway (diamond)."
#define LOC_VALIDATION_CONVERGE_OUTGOING    @"Converging gateway ('%@') has multiple outgoing connections, but can only have one. You can use diverging gateway (diamond) to fork the workflow or remove unnecessary connections."
#define LOC_VALIDATION_CONVERGE_INCOMING_NO @"Converging gateway ('%@') has no incoming connections, but expects at least two."
#define LOC_VALIDATION_CONVERGE_OUTGOING_NO @"Converging gateway ('%@') has no outgoing connections, but can only have one."


#define LOC_VALIDATION_CATEGORY_MUST        @"Please select category where to save the process"
#define LOC_VALIDATION_PROCESS_VAR_DUPLICAT @"Process variable [%@] is being declared more than once."
#define LOC_VALIDATION_PROCESS_VAR_SPACE    @"Process variable [%@] can't contain a space."
#define LOC_VALIDATION_REU_ATTACHED_SP      @"An attached reusable subprocess is required for [%@]"
#define LOC_VALIDATION_SEGMENT_INCOMING     @"Segment ('%@') has multiple incoming connections, but can only have one. You can use converging gateway to bring connections to one or remove unnecessary connections."
#define LOC_VALIDATION_SEGMENT_OUTGOING     @"Segment ('%@') has multiple outgoing connections, but can only have one. You can use diverging gateway (diamond) to fork the workflow or remove unnecessary connections."
#define LOC_VALIDATION_ENDNODE_CONNEC       @"End node can only have one incoming connection and can't have outgoing connections."
#define LOC_VALIDATION_LINE_CONDITION       @"Connection to node '%@' does not have a condition defined. Each outgoing connection from a gateway needs to have a condition defined."
#define LOC_VALIDATION_LINE_DEFAULT_COND    @"Default Conditional %@ line that is comming from %@ should not have any condition defined."
#define LOC_VALIDATION_LINE_MORE_DEFAULT_COND @"Default Conditional should be set for only one line. But more than one line comming from %@ has set as default lines."
#define LOC_VALIDATION_LINE_DEFAULT_ENABLE  @"Default Condition cant be enabled for %@ line that is comming from %@"
#define LOC_VALIDATION_STARTNODE_CONNEC     @"Start node can only have one outgoing connection and no incoming connections."
#define STANDARDTYPE                        @"standardType"

#define LOC_VALIDATION_PROCESS_UUID         @"Process Uuid should not be nil or empty"
#define LOC_VALIDATION_CATEGORY_EMPTY       @"Process category not supported any empty space in between"
#define LOC_VALIDATION_SEGMENT_NO_INCOMING  @"'%@' Segment has no incoming connection. One incoming connection is required (Segment has to be connected)."
#define LOC_VALIDATION_SEGMENT_NO_OUTGOING  @"'%@' Segment has no outgoing connection. One outgoing connection is required (Segment has to be connected)."

#define LOC_VALIDATION_EXPIREAT             @"Node '%@' Escalation Time is mandatory for highlighted task."
#define LOC_VALIDATION_WHEN                 @"Node '%@' Escalation when is mandatory for highlighted task."
//----------------------------------------------------------------------------------------------------------------------

#define LOC_TLE_CAT_SAVE_FAIL               @"Fail to save the data"
#define LOC_TLE_CAT_EMPTY                   @"Category Name is mandatory"
#define LOC_TLE_CAT_EMPTY_SPACE             @"Category Name should not contain any space between name"


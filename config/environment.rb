# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!


# constants
MsgType = {:msg_suc => "mapleMsgSuc", :msg_err => "mapleMsgError", :user_err => "mapleUserUpdateError", :user_suc => "mapleUserUpdateSuccessful"}
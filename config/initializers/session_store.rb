# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_PersonLab_session',
  :secret      => '8f6b8c74e1cf233e75837ad118ba4cdc0cad5a08d634c3cd654a9eea3ad8ba4ac35cae7e8e4604b22a399ccdbbbd8a04742a7d2d2bd471454a7dec6f54fec020'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_marktag_session',
  :secret      => 'fcb833db5ac00b6ea1642d355e42ab0735348ba2885753e1d18e97ef83959b9ed066174fe627ada5a3db878b1bae74000083b285c3aed77e232873f78585da10'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

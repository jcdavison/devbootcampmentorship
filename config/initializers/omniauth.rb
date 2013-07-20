Rails.application.config.middleware.use OmniAuth::Builder do

  provider :linkedin, ENV['BOOT_BOOK_KEY'], ENV['BOOT_BOOK_SECRET'], :scope => 'r_basicprofile r_emailaddress ', :fields => ["id", "email-address", "first-name", "last-name", "headline", "industry", "picture-url", "public-profile-url", "location"]
end
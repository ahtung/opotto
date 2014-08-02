MangoPay.configure do |c|
  c.preproduction = !Rails.env.production?
  c.client_id = ENV['MANGOPAY_CLIENT_ID']
  c.client_passphrase = ENV['MANGOPAY_CLIENT_PASSWORD']
end
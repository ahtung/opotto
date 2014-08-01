user_credentials = {
    :access_token => 'access_token',
    :refresh_token => 'refresh_token',
    :expires_at => Time.now + 1.day
}
coinbase = Coinbase::OAuthClient.new(ENV['COINBASE_CLIENT_ID'], ENV['COINBASE_CLIENT_SECRET'], user_credentials)
# spec/support/omniauth_macros.rb
module OmniauthMacros
  def mock_auth_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:google_oauth2] = {
      'provider' => 'google_oauth2',
      'uid' => '123545',
      'info' => {
        'email' => 'mockuser@gmail.com',
        'name' => 'mock user'
      },
      'credentials' => {
        'token' => 'mock_token',
        'refresh_token' => '1/-99jgdtL0vx_9HquYsxDrACoKKcrbpF071LP7k9DOb8',
        'secret' => 'mock_secret'
      }
    }
  end
end
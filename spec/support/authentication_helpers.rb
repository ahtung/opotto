# AuthenticationHelpers
module AuthenticationHelpers
  # mock omniauth hash
  def omniauth_hash(email)
    OmniAuth::AuthHash.new(
      provider: 'google',
      uid: '1337',
      info: {
        email: email,
        password: Faker::Internet.password,
        credentials: {
          refresh_token: 'TOKEN_STRING'
        }
      }
    )
  end

  def login(user)
    login_as user, scope: :user
    user
  end
end

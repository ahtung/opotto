# AuthenticationHelpers
module AuthenticationHelpers
  # mock omniauth hash
  def omniauth_hash(email, password)
    OmniAuth::AuthHash.new({
      provider: 'google',
      uid: '1337',
      info: {
        email: email,
        password: password
      }
    })
  end
end
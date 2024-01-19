require 'jwt'
module JsonWebToken
  extend ActiveSupport::Concern
  SECRET_KEY = Rails.application.secrets.jwt_secret_key

  def decode_token(token)
    begin
      decoded_token = JWT.decode(token, SECRET_KEY)[0]
      HashWithindifferentAccess.new decoded_token
    rescue JWT::DecodeError
      return nil
    end
  
    payload
  end

  def encode_token(payload, exp = 1.day.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end
end

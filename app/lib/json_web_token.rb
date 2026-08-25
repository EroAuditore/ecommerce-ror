# Codifica/decodifica el JWT que el monolito firma para que los MFEs (ej.
# checkout-mfe) lo manden en el header Authorization. La sesión del propio
# monolito sigue siendo la cookie de Devise; esto es solo la credencial
# compartida hacia afuera.
class JsonWebToken
  ALGORITHM = "HS256"

  def self.encode(payload, exp: 24.hours.from_now)
    payload = payload.dup
    payload[:exp] = exp.to_i
    JWT.encode(payload, secret, ALGORITHM)
  end

  def self.decode(token)
    body = JWT.decode(token, secret, true, algorithm: ALGORITHM).first
    ActiveSupport::HashWithIndifferentAccess.new(body)
  rescue JWT::DecodeError, JWT::ExpiredSignature
    nil
  end

  def self.secret
    Rails.application.secret_key_base
  end
end

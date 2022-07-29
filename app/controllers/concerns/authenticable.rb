module Authenticable
  private

  def authenticate_with_token
    @token ||= request.headers['authorization']

    unless valid_token?
      render json: { errors: 'Por favor forneça um token válido' },
             status: :unauthorized
    end
  end

  def valid_token?
    @token.present? && @token == Rails.application.credentials.token
  end
end
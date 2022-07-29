module Authenticable
  private

  def authenticate_with_token
    @token ||= request.headers['authorization']

    unless valid_token?
      render json: { errors: 'Forneça um header authorization para se identificar, tamanho mínimo: 10 carácteres' },
             status: :unauthorized
    end
  end

  def valid_token?
    @token.present? && @token.size >= 10
  end
end
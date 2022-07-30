module Authenticable
  private

  def authenticate_with_token
    @token ||= request.headers['authorization']

    unless valid_token?
      render json: { errors: 'Provide a header authorization to identify yourself, minimum length: 10 characters' },
             status: :unauthorized
    end
  end

  def valid_token?
    @token.present? && @token.size >= 10
  end
end
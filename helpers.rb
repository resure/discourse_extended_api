
helpers do
  def protected!
    return if authorized? || ENV['FREE_AUTH'] === 'allow'
    halt 401, { error: 'Not Authorized' }.to_json
  end

  def authorized?
    request.env['HTTP_AUTH_TOKEN'] == ENV['AUTH_TOKEN']
  end
end

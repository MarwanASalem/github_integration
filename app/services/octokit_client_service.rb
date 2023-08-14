class OctokitClientService

  def initialize(github_access_token)
    @github_access_token = github_access_token
  end

  def call
    client = Octokit::Client.new(:access_token => "@github_access_token")
    begin
      user = client.user
      client.repos(user.login, query: {type: 'owner', sort: 'asc'})
    rescue StandardError => e
      [{
        error_message: handle_error_message(e)
      }]
    end
  end

  def handle_error_message(error)
    return "Connection failed, please check your internet connection." if error.class == Faraday::ConnectionFailed

    return "You are not authorized to perform this action." if error.class == Octokit::Unauthorized

    "Unknown error occured"
  end
end
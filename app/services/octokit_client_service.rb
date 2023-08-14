class OctokitClientService

  def initialize(github_access_token)
    @github_access_token = github_access_token
  end

  def call
    client = Octokit::Client.new(:access_token => @github_access_token)

    begin
      user = client.user
      client.repos(user.login, query: {type: 'owner', sort: 'asc'})
    rescue StandardError => e
      [{
        error_message: e.message
      }]
    end
  end
end
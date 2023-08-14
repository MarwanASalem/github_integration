class GithubGraphqlApi
  BASE_URL = 'https://api.github.com/graphql'.freeze

  def initialize(**args)
    @owner = args[:owner]
    @name = args[:name]
    @github_access_token = args[:github_access_token]
  end


  def call
    query = <<~GRAPHQL
      query($owner: String!, $name: String!) {
        repository(owner: $owner, name: $name) {
          name
          description
          stargazerCount
        }
      }
    GRAPHQL

    variables = {
      owner: @owner,
      name: @name
    }

    response = HTTParty.post(
      BASE_URL,
      headers: {
        'Authorization': "Bearer #{@github_access_token}",
        'Content-Type': 'application/json'
      },
      body: { query: query, variables: variables }.to_json
    )

    if response.code == 200
      data = JSON.parse(response.body)['data']['repository']
      {
        name: data['name'],
        description: data['description'],
        stargazer_count: data['stargazerCount']
      }
    else
      {
      error_message: 'Failed to fetch repository information'
      }
    end
  end
end

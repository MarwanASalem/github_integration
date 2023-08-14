class RepositoriesController < ApplicationController

  def index
    @repos = OctokitClientService.new(current_user.github_access_token).call
  end

  def repo_details
    @repository = GithubGraphqlApi.new(
      owner: params[:repo_name].split('/', 2).first,
      name: params[:repo_name].split('/', 2).second,
      github_access_token: current_user.github_access_token
    ).call
  end
end

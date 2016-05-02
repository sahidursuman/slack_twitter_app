class UsersController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    user.team_domain = ENV['SLACK_TEAM_DOMAIN']
    user.slack_token = ENV['SLACK_TOKEN']
    user.save
    redirect_to root_path
  end
end

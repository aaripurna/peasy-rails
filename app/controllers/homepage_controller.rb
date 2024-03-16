class HomepageController < ApplicationController
  def home
    pagination, users = pagy(User)
    @pagination = pagination.as_json
    @users = users.as_json
  end
end

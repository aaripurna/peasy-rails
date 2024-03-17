class HomepageController < ApplicationController
  def home
    pagination, users = pagy(User)
    @pagination = pagination.as_json
    @users = users.as_json
    @daily_record = DailyRecord.first&.as_json
  end

  def user_counts
    daily_record = DailyRecord.first&.as_json
    render json: daily_record || {}, status: :ok
  end

  def delete_user
    UserDeletorForm.new(delete_user_params).perform
    redirect_to action: :home
  end

  private

  def delete_user_params
    params.permit(:uuid)
  end
end

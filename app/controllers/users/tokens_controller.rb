class Users::TokensController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  before_action :set_user

  def update
    if @user.update(token: SecureRandom.hex)
      redirect_to users_path, notice: "Token Updated"
    else
      redirect_to users_path, alert: "Error updating token: #{@user.errors.full_messages.to_sentance}"
    end
  end

  private

  def set_user
    pp params
    @user = User.find(params[:id])
  end

  def not_found
    redirect_to users_path, alert: "Record not found"
  end
end

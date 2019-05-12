class Api::V1::FollowsController < ApplicationController
  def destroy
    @follow = Follow.find(params[:id])
    error_message('Not allowed doing this operation', :unprocessable_entity) \
      if @follow.from_user_id != @current_user.id
    @follow.destroy
  end
end

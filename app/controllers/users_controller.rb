class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        @belong_group = current_user.groups
        @belong_group_id = @belong_group.ids
        @groups = Group.where(id: @belong_group_id)
    end
end

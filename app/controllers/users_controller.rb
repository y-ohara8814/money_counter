class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        @belong_group_id = current_user.groups.ids
        @groups = Group.find([@belong_group_id])

    end
end

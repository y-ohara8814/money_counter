class UsersController < ApplicationController
    before_action :authenticate_user!, only: [:show]


    def show
        @user = User.find(params[:id])
        @belong_group_id = current_user.groups.ids
        if @belong_group_id.present?
            @groups = Group.find([@belong_group_id])
        end
        if params[:id] != current_user.id
            flash.now.alert = "ご自分のユーザー情報のみご覧いただけます"
        end
    end
end

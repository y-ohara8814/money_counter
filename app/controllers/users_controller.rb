class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        @belong_group_id = current_user.groups.ids
        # あるユーザーが所属しているgroupのidについて、同じgroupのidを持つ他のuserのnameが欲しい
        @groups = Group.find([@belong_group_id])

    end
end

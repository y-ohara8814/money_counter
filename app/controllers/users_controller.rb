class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
        # @belong_group = current_user.groups
        @belong_group_id = current_user.groups.ids
        # あるユーザーが所属しているgroupのidについて、同じgroupのidを持つ他のuserのnameが欲しい
        # ユーザーが所属するgroupのidを取得→group_userテーブルでそのid(group_id)をもつuser_idを取得
        # そのuser_idをもつユーザーをUserテーブルから取得??
        @group = Group.find([@belong_group_id]).users

        @group_users = GroupUser.where(group_id: @belong_group_id)

        @groups = Group.where(id: @belong_group_id)

    end
end

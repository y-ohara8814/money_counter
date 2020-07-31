class GroupsController < ApplicationController
    require "pry"

    def index
        @text = 'ようこそ、グループのインデックスページです'
    end

    def new
        @group = Group.new
        @group.group_users.build

        @users = User.all
    end

    def create

        @group = Group.new(group_params)
        if group_params[:user_ids]&.exclude?(current_user.id.to_s)
            flash.now[:alert] = "所属するメンバーは、自分を含む１名以上を選択してください"
            render("groups/new") and return
        end
        if @group.save
            flash[:notice] = "グループを作成しました"
            # redirect_to("/groups/new")
            redirect_to("/users/#{current_user.id}")
        else
            flash.now[:alert] = "グループ作成に失敗しました"
            render("groups/new")
        end
    end

    def show

    end

    private
        def group_params
            params.require(:group).permit(:name, { user_ids: [] })
        end



end

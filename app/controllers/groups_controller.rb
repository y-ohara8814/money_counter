class GroupsController < ApplicationController

    def index
        @text = 'ようこそ、グループのインデックスページです'
    end

    def new
        @group = Group.new
        @group.group_users.build

        @users = User.all  #Userテーブルの中の全てのユーザーを配列形式で格納したい
    end

    def create
        @group = Group.new(group_params)
        # @group_user = GroupUser.new(user_id: current_user.id, group_id: @group.id)
        if @group.save!
            flash[:notice] = "グループを作成しました"
            redirect_to("/groups/new")
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

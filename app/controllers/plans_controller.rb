class PlansController < ApplicationController
    #グループIDに紐づくプランを表示
    def index
        @group_name = Group.find(params[:group_id]).name
        @plan = Plan.find(params[:group_id])
    end
    #プラン登録画面描画用
    def new
        #確認画面から戻ってきた場合??

        #初回アクセスの場合
        @plan = Plan.new
        @group = Group.find(params[:group_id])
    end

    def confirm
        @plan = Plan.new(plan_params)
        return if @plan.valid?
        render :new
    end

    def back
        render :new
    end

    #プラン登録画面からパラメータがPOSTされてきたときの処理
    def create
        @group = Group.find(params[:group_id])
        @plan = Plan.new(plan_params)
        if @plan.save!
            flash[:notice] = "プランを作成しました"
            redirect_to("/groups/#{params[:group_id]}/plans")
        else
            flash.now[:alert] = "プラン作成に失敗しました"
            render("plans/new")
        end
    end

    private 
        def plan_params
            params.require(:plan).permit(:money_amount, :year, :month, :group_id)
        end
end

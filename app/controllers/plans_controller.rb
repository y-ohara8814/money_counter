class PlansController < ApplicationController
    before_action :plan_params, only:[:create,:confirm,:back]
    #グループIDに紐づくプランを表示
    def index
        @group = Group.find_by(id: params[:group_id])
        @group_name = Group.find_by(id: params[:group_id]).name
        @plan = Plan.find_by(group_id: params[:group_id])
        @usage = Usage.new
    end
    #プラン登録画面描画用
    def new
        @plan = Plan.new
        @group = Group.find(params[:group_id])
    end

    def confirm
        @plan = Plan.new(plan_params)
        @group = Group.find(params[:group_id])
        return if @plan.valid?
        render :new
    end

    def back
        @plan = Plan.new(plan_params)
        @group = Group.find(params[:group_id])
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

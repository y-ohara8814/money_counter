class PlansController < ApplicationController
    #グループIDに紐づくプランを表示
    def index
        @group_name = Group.find(params[:id]).name
        
    end
    #プラン登録画面描画用
    def new
        @plan = Plan.new
    end
    #プラン登録画面からパラメータがPOSTされてきたときの処理
    def create
        @plan = Plan.new(plan_params)
        if @plan.save!
            flash[:notice] = "グループを作成しました"
            redirect_to("/plans/#{params[:id]}/plan")
        else
            flash.now[:alert] = "グループ作成に失敗しました"
            render("plans/new")
        end
    end

    private 
        def plan_params
            params.require(:plan).permit(:money_amount, :year, :month)
        end
end

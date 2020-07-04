class PlansController < ApplicationController
    require "pry"
    before_action :plan_params, only:[:create,:confirm,:back]
    #グループIDに紐づくプランを表示
    def index
        @group = Group.find_by(id: params[:group_id])
        @group_name = Group.find_by(id: params[:group_id]).name
        @plan = Plan.find_by(group_id: params[:group_id])
        @usages = Usage.where(plan_id: @plan.id)
        
        @usage = Usage.new
    end
    #プラン登録画面描画用
    def new
        @plan = Plan.new
        @group = Group.find(params[:group_id])
    end

    #プラン編集画面描画用
    def edit
        @plan = Plan.find(params[:id])
        find_group()
    end

    def confirm
        @plan = Plan.new(plan_params)
        @group = Group.find(params[:group_id])
        return if @plan.valid?
        render :new
    end

    def edit_confirm
        @plan = Plan.new(edit_plan_params)
        find_group()
        @edit_flg = params[:edit_flg]
        return if @plan.valid?
        render :edit
    end

    def back
        @edit_flg = edit_plan_params[:edit_flg]
        if @edit_flg == true
            @plan = Plan.new(edit_plan_params)
            find_group()
            render :edit
        else
            @plan = Plan.new(plan_params)
            @group = Group.find(params[:group_id])
            render :new
        end
    end

    #プラン登録画面からパラメータがPOSTされてきたときの処理
    def create
        @group = Group.find(params[:group_id])
        @plan = Plan.new(plan_params)
        if @plan.save
            flash[:notice] = "プランを作成しました"
            redirect_to("/groups/#{params[:group_id]}/plans")
        else
            flash.now[:alert] = "プラン作成に失敗しました"
            render("plans/new")
        end
    end

    def update

    end

    private 
        def plan_params
            params.require(:plan).permit(:money_amount, :year, :month, :choice1, :choice2, :choice3, :group_id)
        end
    private 
        def edit_plan_params
            params.require(:plan).permit(:money_amount, :year, :month,:choice1, :choice2, :choice3, :group_id, :edit_flg)
        end

    private
        def find_group
            @group = Group.find(params[:group_id])
        end
end

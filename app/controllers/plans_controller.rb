class PlansController < ApplicationController
    require "pry"
    before_action :plan_params, only:[:create,:confirm,:back]
    #グループIDに紐づくプランを表示
    def index
        @group = Group.find_by(id: params[:group_id])
        @group_name = Group.find_by(id: params[:group_id]).name
        @plan = Plan.find_by(group_id: params[:group_id])
        @usages = Usage.where(plan_id: @plan.id)
        @spending_money_total = @usages.all.sum(:spending_money)
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

    #プラン編集画面描画用
    def edit
        @plan = Plan.find(params[:id])
        find_group()
    end

    def edit_confirm
        @plan = Plan.new(plan_params)
        find_group()
        @edit_flg = params[:edit_flg]
        return if @plan.valid?
        render :edit
    end

    def edit_back
            @plan = Plan.new(plan_params)
            find_group()
            render :edit
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
    #プラン編集画面からパラメータがPOSTされてきたときの処理
    def update
        @plan = Plan.find_by(group_id: params[:group_id], id: params[:id])
        if @plan.update(plan_params)
            flash[:notice] = "プランを編集しました"
            redirect_to("/groups/#{params[:group_id]}/plans")
        else
            flash.now[:alert] = "プラン編集に失敗しました"
            render :edit
        end
    end

    private 
        def plan_params
            params.require(:plan).permit(:money_amount, :year, :month, :choice1, :choice2, :choice3, :group_id)
        end

    private
        def find_group
            @group = Group.find(params[:group_id])
        end
end

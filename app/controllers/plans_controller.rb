class PlansController < ApplicationController
    require "pry"
    require "date"

    before_action :plan_params, only:[:create,:confirm,:back]
    #グループIDに紐づくプランを表示
    def index
        @group = Group.find_by(id: params[:group_id])
        @group_name = Group.find_by(id: params[:group_id]).name
        @plan = Plan.find_by(group_id: params[:group_id])
        @plan_all = Plan.where(group_id: params[:group_id])
        if @plan.present?
            @usages = Usage.where(plan_id: @plan.id)
            @spending_money_total = @usages.all.sum(:spending_money)
        end

        @usage = Usage.new

        #URLのクエリパラメータの有無を確認
        if params[:datetime].present?
            #クエリパラメータがあったら、その年月情報を取得

            query_datetime_int = Date.parse(params[:datetime])
            param_year = query_datetime_int.year
            param_month = query_datetime_int.month
            @current_date = Date.new(param_year, param_month)
            #クエリパラメータの年月と合致する年月のプランがあるかをチェック
            @plan_specific = Plan.where(group_id: params[:group_id], year: param_year, month: param_month).first
            #クエリパラメータの年月と合致する年月のプランがあったら、それを@planとしてviewに渡す
            if @plan_specific.present?
                @query_date_match_flag = true
                @plan = @plan_specific
                @next_month = @current_date.next_month
                @prev_month = @current_date.prev_month
            else
            #クエリパラメータの年月と合致する年月のプランがなかったら、「この月のプランは設定されていません」的なページを表示
                @date_match_flag = false
                @plan.year = 9999
                @plan.month = 9
            end



        else
            #URLにクエリパラメータがなかったら現在年月と合致するプランがあるかをチェック
            @current_date = Date.today
            @current_year = @current_date.year
            @current_month = @current_date.month
            @next_month = @current_date.next_month
            @prev_month = @current_date.prev_month
            @plan_specific = Plan.where(group_id: params[:group_id], year: @current_year, month: @current_month).first
            #現在年月と合致する年月のプランがあったら、それを@planとしてviewに返す
            if @plan_specific.present?

                @plan = @plan_specific


            else

            #現在年月と合致する年月のプランがなかったら、「この月のプランは設定されていません」的なページを表示
                @date_match_flag = false

            end



            #また、プラン作成を促すページも表示



        end

        #クエリパラメータの年月が現在〜未来だったら、プラン作成を促すページも表示
        # if @date_match_flag != false && (param_year < @current_date.year || param_month < @current_date.month)

        # end
            #クエリパラメータの年月が過去だったら、プラン作成は不可


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

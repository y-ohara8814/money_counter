class PlansController < ApplicationController
    require "date"

    before_action :plan_params, only:[:create,:confirm,:back]
    before_action :user_match_check
    #グループIDに紐づくプランを表示
    def index
        @group = Group.find_by(id: params[:group_id])
        @group_name = Group.find_by(id: params[:group_id]).name
        @plan = Plan.find_by(group_id: params[:group_id])
        @plan_all = Plan.where(group_id: params[:group_id])

        @usage = Usage.new

        #URLのクエリパラメータの有無を確認
        if params[:datetime].present?
            #クエリパラメータがあったら、その年月情報を取得
            query_datetime_int = Date.parse(params[:datetime])
            @param_year = query_datetime_int.year
            @param_month = query_datetime_int.month
            @current_date = Date.new(@param_year, @param_month).end_of_month
            #クエリパラメータの年月と合致する年月のプランがあるかをチェック
            @plan_specific = Plan.where(group_id: params[:group_id], year: @param_year, month: @param_month).first
            #クエリパラメータの年月と合致する年月のプランがあったら、それを@planとしてviewに渡す
            if @plan_specific.present?
                @query_date_match_flag = true
                @plan = @plan_specific
                @next_month = @current_date.next_month
                @prev_month = @current_date.prev_month
            else
            #クエリパラメータの年月と合致する年月のプランがなかったら、「この月のプランは設定されていません」的なページを表示
                @date_match_flag = false
                #クエリパラメータの年月が現在以降だったら、プラン作成ボタン表示用のフラグをたてる
                if @current_date >= Date.today
                    @past_date_flag = false
                else
                    @past_date_flag = true
                end
                @next_month = @current_date.next_month
                @prev_month = @current_date.prev_month
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
                #年月が現在以降だったら、プラン作成ボタン表示用のフラグをたてる
                if @current_date >= Date.today
                    @past_date_flag = false
                else
                    @past_date_flag = true
                end

            end

        end
        #月初月末情報取得
        begin_of_month = @current_date.beginning_of_month
        end_of_month = @current_date.end_of_month

        #利用履歴表示
        if @plan.present?
            @usages = Usage.where(plan_id: @plan.id).where("date >= ?", begin_of_month).where("date <= ?", end_of_month).order(date: "DESC")
            @spending_money_total = @usages.all.sum(:spending_money)
            @spending_money_each = Usage.joins(:user).select('user.name').where(plan_id: @plan.id).where("date >= ?", begin_of_month).where("date <= ?", end_of_month).group(:name).sum(:spending_money)
            @zandaka = @plan.money_amount - @spending_money_total
        end

        #円グラフ表示用
        if @plan_specific.present?
            @usage_sum_arr = @usages.group(:purpose).sum(:spending_money)
            @chart = {@plan_specific.choice1 => @usage_sum_arr[@plan_specific.choice1], @plan_specific.choice2 => @usage_sum_arr[@plan_specific.choice2], @plan_specific.choice3 => @usage_sum_arr[@plan_specific.choice3]}
        end
    end
    #プラン登録画面描画用
    def new
        @plan = Plan.new
        @group = Group.find(params[:group_id])
        @new_flag = true
        @edit_flag = false
    end

    def confirm
        @plan = Plan.new(plan_params)
        @group = Group.find(params[:group_id])
        @new_flag = true
        @edit_flag = false
        return if @plan.valid?
        render :new
    end

    def back
            @plan = Plan.new(plan_params)
            @group = Group.find(params[:group_id])
            @new_flag = true
            @edit_flag = false
            render :new
    end

    #プラン編集画面描画用
    def edit
        @plan = Plan.find(params[:id])
        find_group()
        @new_flag = false
        @edit_flag = true
    end

    def edit_confirm
        @plan = Plan.find(params[:id])
        @plan.money_amount = plan_params[:money_amount]
        @plan.year = plan_params[:year]
        @plan.month = plan_params[:month]
        @plan.choice1 = plan_params[:choice1]
        @plan.choice2 = plan_params[:choice2]
        @plan.choice3 = plan_params[:choice3]
        @plan.group_id = plan_params[:group_id]
        find_group()
        @edit_flg = params[:edit_flg]
        return if @plan.valid?
        render :edit
    end

    def edit_back
            @plan = Plan.new(plan_params)
            @new_flag = false
            @edit_flag = true
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

    private
        def user_match_check
            @belong_group_ids = current_user.groups.ids #配列形式
            if @belong_group_ids.include?(params[:group_id].to_i)
                @user_match_flag = true
            else
                @user_match_flag = false
            end
        end
end

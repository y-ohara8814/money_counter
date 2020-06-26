class UsagesController < ApplicationController

        def new
            
        @group = Group.find_by(id: params[:group_id])
        @group_name = Group.find_by(id: params[:group_id]).name
        @plan = Plan.find_by(group_id: params[:group_id])
        @usages = Usage.where(plan_id: @plan.id)
        
        @usage = Usage.new
        end

        def create
            @group = Group.find(params[:group_id])
            usage_current_params = usage_params
            if params[:usage][:purpose_text].present? && usage_current_params[:purpose] == "other"
                usage_current_params[:purpose] = params[:usage][:purpose_text]
            end
            @usage = Usage.new(usage_current_params)
            if @usage.save
                flash[:notice] = "利用内容を登録しました"
                redirect_to("/groups/#{params[:group_id]}/plans")
            else
                @plan = Plan.find_by(group_id: params[:group_id])
                flash.now[:alert] = "登録に失敗しました。お手数ですが再度入力してください"
                render template: "/usages/new"
            end
        end

    private 
        def usage_params
            params.require(:usage).permit(:spending_money, :date, :purpose,:plan_id, :user_id)
        end
end

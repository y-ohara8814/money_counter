class UsagesController < ApplicationController
        def create
            @group = Group.find(params[:group_id])
            @usage = Usage.new(usage_params)
            if @usage.save!
                flash[:notice] = "利用内容を登録しました"
                redirect_to("/groups/#{params[:group_id]}/plans")
            else
                flash.now[:alert] = "登録に失敗しました"
                render("/groups/#{params[:group_id]}/plans")
            end
        end

    private 
        def usage_params
            params.require(:usage).permit(:spending_money, :purpose, :date, :plan_id, :user_id)
        end
end

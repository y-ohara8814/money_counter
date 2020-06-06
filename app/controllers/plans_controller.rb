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

    end
end

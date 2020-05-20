class HumanController < ApplicationController
  before_action :logged_in_user, only:[:edit, :update, :destroy]
  # 必要になるかもしれないので残しておく
  # Create内でエラーが発生する様になったら
  # 見返すこと
  #wrap_parameters :human, include: [:name, :email, :password, :password_confirmation]
    def new
     @human = Human.new
    end
    
    def index
      @human = Human.all
    end
    
    def create
     @human = Human.new(human_params)
      if @human.save
        session[:human_id] = @human.id
        redirect_to human_path(@human.id), success: "ユーザー登録が完了しました"
      else
        flash[:error] = "ユーザー登録に失敗しました"
        render :new
      end
    end
    
    def show
      @human = Human.find(current_user.id)
      @weight =retrieve_latestWeight
      @weight_lbs = convKgtoLBS(@weight[0])
      @hash_PFC = calc_PFC(@weight_lbs)
    end

    def destroy 
      @human = Human.find(current_user.id)
      @human.destroy
      redirect_to root_path, success: "退会しました。"
    end
    
    private
    # human_paramsにしないと
    # 新規ユーザー登録時に
    # エラーが発生する
    # password can't be blank
    def human_params
      params.require(:human).permit(:id,:name,:email,:password,:password_confirmation, :admin)
    end

    # ログインユーザーの最新の体重を取得する
    # 返り値は要素数1の配列
    def retrieve_latestWeight
      Weightpost.where(human_id: current_user.id).
      order(created_at: :desc).limit(1).pluck(:weight)
    end

    # 数値をkg→LBSに変換する
    def convKgtoLBS(num)
      num * Conv_Unit::KgToLBS
    end

    # 体重(lbs)からPFCバランスを算出する
    def calc_PFC(weight_lbs)
      # Dorian Yatesの計算式を基に算出
      # 参考: https://www.bodybuilding.com/fun/dorian_yates_nutrition_interview.htm
      protein = weight_lbs * Calc_PFC::ProteinFromLBS
      fat = protein * Calc_PFC::FatFromProtein
      carb = protein * Calc_PFC::CarbFromProtein
      hash_PFC = {
        protein: protein.round,
        fat: fat.round,
        carb: carb.round,
      }
    end
end

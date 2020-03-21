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
        flash[:notice] = "ユーザー登録が完了しました"
        redirect_to human_path(@human.id)
      else
        flash[:notice] = "ユーザー登録に失敗しました"
        render :new
      end
    end
    
    def show
      @human = Human.find_by(params[:id])
    end
    
    private
    # human_paramsにしないと
    # 新規ユーザー登録時に
    # エラーが発生する
    # password can't be blank
    def human_params
      params.require(:human).permit(:id,:name,:email,:password,:password_confirmation, :admin)
    end
end

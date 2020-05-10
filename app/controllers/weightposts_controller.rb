class WeightpostsController < ApplicationController
    def new
      @weightpost = Weightpost.new
    end
    
    def create
      params[:weightpost][:created_at] = recordtime_join
      check_record_day(recordtime_join)
      @weightpost = current_user.weightposts.build(weightpost_params)
      if @weightpost.save
        redirect_to root_url, success: "体重を記録しました"
      else
        flash[:error] = "体重の記録に失敗しました"
        render new_human_weightpost_path
      end
    end
  
    def show

    end
    
    def index
      weightposts = Weightpost.where(human_id: current_user.id)
      @weights= weightposts.pluck(:created_at, :weight)
      @weight_ids = weightposts.pluck(:created_at, :weight, :id)
    end
    
    def destroy
    end
    
    def human
      return Human.find_by(id: self.human_id)
    end
    
    def edit
      @weightpost = Weightpost.find(params[:id])
    end 
    
    def update
      @weightpost = Weightpost.find(params[:id])
      @weightpost.update(weightpost_edit_params)
      redirect_to root_url, success: "体重を更新しました"
    end
    
    # 最も記録日時が新しい体重の値を取得する
    def get_latestWeight
      weightpost = Weightpost.find_by(human_id: current_user.id).order(updated_at: :desc).limit(1)
    end

    private
      # 入力された体重記録日に
      # 既に体重が記録されていないかチェックする
      def check_record_day(recordtime)
        weightposts = Weightpost.where(human_id: current_user.id)
        date = weightposts.pluck(:created_at).map{ |date| I18n.l date, format: :short}
        # 判定用に年/月/日に整形
        record = I18n.l recordtime, format: :default
        if date.include?(record)
          #確認メッセージ
          #OKなら上書きする
          render root_url
        end
      end
      def weightpost_params
        params.require(:weightpost).permit(:weight,:created_at)
      end
      
      # 体重更新用パラメータ
      def weightpost_edit_params
        params.require(:weightpost).permit(:weight)
      end

      # 入力された体重の記録日付を
      # 整形する
      def recordtime_join
        # パラメータ取得
        date = params[:weightpost]
        # ブランク時のエラー回避のため、ブランクだったら何もしない
        if date["created_at(1i)"].empty? && date["created_at(2i)"].empty? && date["created_at(3i)"].empty?
          return
        end
        # 年月日別々できたものを結合して新しいDate型変数を作って返す
        Date.new date["created_at(1i)"].to_i,date["created_at(2i)"].to_i,date["created_at(3i)"].to_i
      end
end

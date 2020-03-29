class WeightpostsController < ApplicationController
  def new
    @weightpost = Weightpost.new
  end
  
  def create
    params[:weightpost][:created_at] = recordtime_join
    @weightpost = current_user.weightposts.build(weightpost_params)
    if @weightpost.save
      redirect_to root_url, success: "体重を記録しました"
    else
      flash[:error] = "体重の記録に失敗しました"
      render new_weightpost_path
    end
  end
  
  def show
    weightposts = Weightpost.where(human_id: current_user.id)
    weights= weightposts.pluck(:weight)
    date = weightposts.pluck(:created_at).map{ |date| I18n.l date}
    ary = [date, weights].transpose
    @h = Hash[*ary.flatten]
  end
  
  def destroy
  end
  
  def human
    return Human.find_by(id: self.human_id)
  end
  
  private

   def weightpost_params
     params.require(:weightpost).permit(:weight,:created_at)
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

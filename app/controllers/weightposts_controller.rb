class WeightpostsController < ApplicationController
  def new
    @weightpost = Weightpost.new
  end
  
  def create
    @weightpost = current_user.weightposts.build(weightpost_params)
    if @weightpost.save
      flash[:success] = "体重を記録しました"
      redirect_to root_url
    else
      flash[:failure] = "体重の記録に失敗しました"
      render new_weightpost_path
    end
  end
  
  def show
    @weightposts = Weightpost.where(human_id: current_user.id)
    @date = @weightposts.pluck(:created_at).map{ |date| date.strftime("%m/%d")}
    @weights= Weightpost.pluck(:weight)
  end
  
  def destroy
  end
  
  def human
    return Human.find_by(id: self.human_id)
  end
  
  private

   def weightpost_params
     params.require(:weightpost).permit(:weight)
   end
end

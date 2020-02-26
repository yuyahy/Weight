class HumanController < ApplicationController
  before_action :logged_in_user, only:[:edit, :update, :destroy]
    def new
      @human = Human.new
    end
    
    def index
      @human = Human.new
    end
    
    def create
      @human = Human.create(human_params)
      redirect_to human_path(@human)
    end
    
    def show
      @human = Human.all
    end
    
    private
    def human_params
      params.require(:human).permit(:weight)
    end
end

class HumanController < ApplicationController
    def new
      @human = Human.new
    end
    
    def index
      @human = Human.new
    end
    
    def create
      @human = Human.create(human_params)
      redirect_to human_path
    end
end

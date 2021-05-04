class PrototypesController < ApplicationController
  def index
    @prototypes = Prototype.all
  end

  def new
    authenticate_user!
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)

  end

  def edit
    authenticate_user!
    @prototype = Prototype.find(params[:id])
    unless user_signed_in? && current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end

  def update
    prototype = Prototype.find(params[:id])
    if  prototype.update(prototype_params)
      redirect_to prototype_path
    else
      @prototype = prototype
      render action: :edit
    end
  end

  def destroy
    authenticate_user!
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end


private

def prototype_params
  
  params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  
end

end
class PrototypesController < ApplicationController
  #アクション前処理
  before_action :set_prototype,       only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!,  only: [:new,  :edit, :destroy]


  #アクション
  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(get_prototype_parameters)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comment    = Comment.new
    @comments   = @prototype.comments.includes(:user)
  end

  def edit
    unless user_signed_in? && (@prototype.user_id == current_user.id)
      redirect_to action: :index
    end
  end

  def update
    if @prototype.update(get_prototype_parameters)
      redirect_to prototype_path(@prototype.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path
  end

  
  #プライベートメソッド
  private

  #投稿内容のパラメーター取得
  def get_prototype_parameters
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  #プロトタイプのデータ取得
  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

end

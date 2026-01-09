class CommentsController < ApplicationController
  #アクション前処理
  before_action :set_prototype, only: [:create, :show]

  #アクション
  def create
    @comment = Comment.new(get_comment_parameters)
    if @comment.save
      redirect_to prototype_path(@comment.prototype_id)
    else
      @comment  = Comment.new
      @comments = @prototype.comments.includes(:user)
      render "prototypes/show", status: :unprocessable_entity
    end
  end

  def show
    @comment  = Comment.new
    @comments = @prototype.comments.includes(:user)
  end


  #プライベートメソッド
  private

  #コメントのパラメーター取得
  def get_comment_parameters
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end

  #プロトタイプのデータ取得
  def set_prototype
    @prototype = Prototype.find(params[:prototype_id])
  end

end

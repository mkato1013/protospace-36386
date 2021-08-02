class PrototypesController < ApplicationController
  before_action :move_to_index, only: [:edit, :update]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new   #この辺理解できていない。newなのかfindなのか？
  end

  def create
    @prototype = Prototype.new(prototype_params)  #「.create」「.new」との違い？？アクティブレコードにcreateはない？？？

    if @prototype.save  #ここのsaveもアクティブレコード？
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])  #showはfindで暗記でいいのか？？あと、(params[:id])の意味がわからない。
    @comment = Comment.new   #ここの2行は、prototypeのビューにつながるところだから、prototypeのコントローラーに記載する。
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])

    if current_user == @prototype.user
      render :edit
    else
      redirect_to root_path
    end

  end

  def update
    @prototype = Prototype.find(params[:id])    #なんでここでは「＠」はないのか。また、なんでここでもparams？？「@を置かないといけない理由は？インスタンス変数とは、何か再度確認。」
       #ここでの「.update」は何？アクティブレコード？

    if @prototype.update(prototype_params)  #ここのsaveもアクティブレコード？  #「＠」をつけない理由は「create」と区別をつけるため？？ #ビューファイルでifを設定しない代わりにコントローラーで変数化させずにコントローラーとは別物とするように更新(保存)にしている？？ #（追記）おそらくsaveではない！if分の前にupdateを置いてしまうと、「もしupdateができたら・・という構文にはならない！」
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy     #ここでの「.destroy」は何？アクティブレコード？
    redirect_to root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image ).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end

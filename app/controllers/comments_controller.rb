class CommentsController < ApplicationController
  
  def create
    @comment = Comment.new(comment_params)  #create→newに変わった理由は？
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      @prototype = @comment.prototype  #この2行をつける意味？1行目は「たくさんのコメントが入っているprototypeを「@prototype」に変数化」2行目はも同じような感じ？もしくは、@prototypeは、prototypeコントローラーでインスタンス変数化した「@prototype」と連動している？？
      @comments = @prototype.comments
      render "prototypes/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end

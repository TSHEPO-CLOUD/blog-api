class Api::CommentsController < Api::ApiController
  acts_as_token_authentication_handler_for User
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    render json: @comments
  end

  def create
    post = Post.find(params[:post_id])
    p current_user.id
    comment = post.comments.build(user_id: current_user.id, content: params[:content])

    if comment.save
      render json: comment
    else
      render plain: 'comment not created', status: :bad_request, message: 'comment not created'
    end
  end
end

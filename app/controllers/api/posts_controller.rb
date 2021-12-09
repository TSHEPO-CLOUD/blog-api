class Api::PostsController < Api::ApiController
  acts_as_token_authentication_handler_for User

  def index
    @post = Post.all
    render json: @post
  end

  def create
    post = Post.new(user_id: current_user.id, content: params)
    if post.save
      response.headers['X-User-email'] = current_user.email
      response.headers['X-User-token'] = current_user.authentication_token
      render json: post, status: :created
    else
      head :bad_request
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end

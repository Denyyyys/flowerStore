class CommentsController < ApplicationController
  def create
    @flower = Flower.find(params[:flower_id])
    @comment = @flower.comments.new(comment_params)
    @comment.user = current_user # Associate the comment with the current user

    if @comment.save
      redirect_to flower_path(@flower), notice: 'Comment added successfully!'
    else
      redirect_to flower_path(@flower), alert: 'Failed to add comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body) # No need to permit first_name/last_name
  end
end

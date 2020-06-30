class CommentsController < ApplicationController

    def index
      respond_with Comments.all
    end

    def show
      respond_with Comments.find(params[:id])
    end

    def create
      respond_with Comments.create(comments_params)
    end

    def update
      comments = Comments.find(params["id"])
      comments.update_attributes(comments_params)
      respond_with comments, json: comments
    end

    def destroy
      respond_with Comments.destroy(params[:id])
    end

    private
    def comments_params
      params.require(:comments).permit(:id, :comment, :commented_id, :commented_type)
    end

  end

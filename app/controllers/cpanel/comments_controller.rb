# ----------------------------------------------------
# name: comments_controller.rb
# authors: Jason Lee<huacnlee@gmail.com>,
# create at: 2009-04-16
# summary:
#   cpanel comments manage controller
# ----------------------------------------------------

class Cpanel::CommentsController < Cpanel::ApplicationController
  cache_sweeper :comment_sweeper,:only => [:destroy]
  
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.find_list(params[:page],8)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { 
        flash[:notice] = "评论删除成功."
        redirect_to(cpanel_comments_url) 
      }
      format.xml  { head :ok }
    end
  end
end

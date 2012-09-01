class GraphsController < ApplicationController
    layout "products"
    def show
        @graph = Graph.find(params[:id])
        if Rating.find_by_graph_id(@graph.id)
            @like_count = Rating.find(:last, :select => ["count(id) as 'cnt'"], :conditions => ["rate=1 and graph_id=#{@graph.id}"])
            @dislike_count = Rating.find(:last, :select => ["count(id) as 'cnt'"], :conditions => ["rate=0 and graph_id=#{@graph.id}"])
            @like = @like_count.cnt
            @dislike = @dislike_count.cnt
        else
            @like = 0
            @dislike = 0
        end
        comment = params[:comment]
        if !comment.nil? 
            if comment.blank?
                flash[:notice] = "Hey, comment can't be blank"
            else
                @comment = Comment.new
                @comment.graph_id = params[:id]
                @comment.comment = comment
                @comment.save
            end
        end
        @comments = Comment.find_all_by_graph_id(@graph.id, :order => "id desc")
    end
end

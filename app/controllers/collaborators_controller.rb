class CollaboratorsController < ApplicationController
  def new
    @wiki = Wiki.find(params[:wiki_id])
  end

  def create
    @collaborator = Collaborator.new(wiki_id: params[:wiki_id], user_id: params[:user_id])
    
    if @collaborator.save
      flash[:notice] = "Wiki was updated."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was an error updating the wiki. Please try again."
      render :new
    end
  end

  def edit
    @user = @wiki.user
    @users = User.all
  end

  def destroy
  end
end

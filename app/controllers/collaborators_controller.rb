class CollaboratorsController < ApplicationController
  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.new
    authorize @collaborator
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new(params.require(:collaborator).permit(:user_id))
    @collaborator.wiki = @wiki
    authorize @collaborator
    if @collaborator.save
      flash[:notice] = "Wiki was updated."
      redirect_to edit_wiki_path(@collaborator.wiki)
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
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "\"#{@collaborator.user.name}\" is no longer a collaborator."  
    else
      flash[:error] = "There was an error deleting the collaborator. Please try again."
    end
    redirect_to edit_wiki_path(@wiki)
  end
end

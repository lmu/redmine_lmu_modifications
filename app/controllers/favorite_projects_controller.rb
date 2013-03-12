class FavoriteProjectsController < ApplicationController
  unloadable
  before_filter :find_project_by_project_id, :except => :search
  
  def search
    seach = params[:q] || params[:project_search]

    scope = Project
    scope = scope.active unless params[:closed]
    scope = scope.scoped(:conditions =>   ["(LOWER(#{Project.table_name}.name) LIKE ? OR 
                                             LOWER(#{Project.table_name}.description) LIKE ?)", 
                                                                  "%" + seach.downcase + "%",
                                                                  "%" + seach.downcase + "%"] ) unless seach.blank?

    @projects = scope.visible.order('lft').all

    respond_to do |format|
      format.html { render :template => "projects/index"}
      format.js { render :partial => "search" }
    end
  end

  def favorite
    if @project.respond_to?(:visible?) && !@project.visible?(User.current)
      render_403
    else
      set_favorite(User.current, true)
    end       
  end

  def unfavorite
     set_favorite(User.current, false)
  end

  # Returns the css class used to identify watch links for a given +object+
  def favorite_css(object)
    "#{object.class.to_s.underscore}-#{object.id}-favorite"
  end
  
  private
  
  def set_favorite(user, favorite)
    if favorite 
      favorite_project = FavoriteProject.find_by_project_id_and_user_id(@project.id, user.id)
      favorite_project.delete if favorite_project
    else
      FavoriteProject.create(:project_id => @project.id, :user_id => user.id)
    end
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render :partial => 'set_favorite' }
    end

  rescue ::ActionController::RedirectBackError
    render :text => (favorite ? 'Favorite added.' : 'Favorite removed.'), :layout => true
  end

end

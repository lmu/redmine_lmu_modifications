module RedmineFavoriteProjects
  module Patches

    module ProjectsControllerPatch

      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods


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
          end

        rescue ::ActionController::RedirectBackError
          render :text => (watching ? 'Favorite added.' : 'Favorite removed.'), :layout => true
        end

        
      end

    end
  end
end

Dispatcher.to_prepare do  
  unless ProjectsController.included_modules.include?(RedmineFavoriteProjects::Patches::ProjectsControllerPatch)
    ProjectsController.send(:include, RedmineFavoriteProjects::Patches::ProjectsControllerPatch)
  end
end
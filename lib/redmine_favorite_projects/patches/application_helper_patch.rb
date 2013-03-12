module RedmineFavoriteProjects
  module Patches

    module ApplicationHelperPatch

      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable 
          alias_method_chain :render_project_jump_box, :only_favorites
        end
      end

      module InstanceMethods
        # Adds a rates tab to the user administration page
        def render_project_jump_box_with_only_favorites
          return unless User.current.logged?
          favorite_projects = FavoriteProject.find(:all, :conditions => {:user_id => User.current.id})
          favorite_projects_ids = favorite_projects.map(&:project_id)
          projects = User.current.memberships.collect(&:project).compact.uniq.select{|p| !favorite_projects_ids.include?(p.id) && p.active? }
          if projects.any?
            s = '<select onchange="if (this.value != \'\') { window.location = this.value; }">' +
            "<option value=''>#{ l(:label_jump_to_a_project) }</option>" +
            '<option value="" disabled="disabled">---</option>'
            s << project_tree_options_for_select(projects, :selected => @project) do |p|
              { :value => url_for(:controller => 'projects', :action => 'show', :id => p, :jump => current_menu_item) } 
            end
            s << '</select>'
            s.html_safe
          end        
        end
        
      end

    end
  end
end

ActionDispatch::Reloader.to_prepare do  
  unless ApplicationHelper.included_modules.include?(RedmineFavoriteProjects::Patches::ApplicationHelperPatch)
    ApplicationHelper.send(:include, RedmineFavoriteProjects::Patches::ApplicationHelperPatch)
  end
end
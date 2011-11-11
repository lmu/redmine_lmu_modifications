module RedmineProjectsExtensions
  module Patches

    module ProjectsHelperPatch

      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        include FavoriteProjectsHelper
      end

    end
  end
end

Dispatcher.to_prepare do  
  unless ProjectsHelper.included_modules.include?(RedmineProjectsExtensions::Patches::ProjectsHelperPatch)
    ProjectsHelper.send(:include, RedmineProjectsExtensions::Patches::ProjectsHelperPatch)
  end
end
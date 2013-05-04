require 'redmine'

Redmine::Plugin.register :redmine_favorite_projects do
  name 'Redmine Favorite Projects plugin'
  author 'RedmineCRM'
  description 'This is a favorite projects plugin for Redmine'
  version '1.0.1'
  url 'http://redminecrm.com/projects/favoriteprojects'
  author_url 'mailto:support@redminecrm.com'

  requires_redmine :version_or_higher => '2.1.2'

end

require 'redmine_favorite_projects/patches/application_helper_patch'
require 'redmine_favorite_projects/patches/projects_controller_patch'
require 'redmine_favorite_projects/patches/projects_helper_patch'

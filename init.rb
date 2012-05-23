require 'redmine'
require 'dispatcher'  

require 'redmine_favorite_projects/patches/application_helper_patch'
# require 'redmine_projects_extensions/patches/projects_controller_patch'
require 'redmine_favorite_projects/patches/projects_helper_patch'


Redmine::Plugin.register :redmine_favorite_projects do
  name 'Redmine Favorite Projects plugin'
  author 'RedmineCRM'
  description 'This is a plugin for Redmine'
  version '0.0.2'
  url 'http://redminecrm.com'
  author_url 'mailto:kirbez@redminecrm.com'
end

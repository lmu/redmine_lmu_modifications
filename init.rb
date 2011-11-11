require 'redmine'
require 'dispatcher'  

require 'redmine_projects_extensions/patches/application_helper_patch'
# require 'redmine_projects_extensions/patches/projects_controller_patch'
require 'redmine_projects_extensions/patches/projects_helper_patch'


Redmine::Plugin.register :redmine_projects_extensions do
  name 'Redmine Projects Extensions plugin'
  author 'Kirill Bezrukov'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end


Redmine::Plugin.register :redmine_lmu_modifications do
  name 'Redmine LMU modifications plugin'
  author 'AlphaNodes GmbH'
  description 'Customizing for LMU Redmine'
  version '0.0.1'
  author_url 'http://alphanodes.de'
end

require 'redmine_lmu_modifications/patches/application_helper_patch'

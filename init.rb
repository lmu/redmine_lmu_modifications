# encoding: utf-8
#

Redmine::Plugin.register :redmine_lmu_modifications do
  name 'Redmine LMU modifications plugin'
  author 'AlphaNodes GmbH'
  description 'Customizing for LMU Redmine'
  version '0.0.1'
  author_url 'http://alphanodes.de'
end

unless ApplicationHelper.included_modules.include? RedmineLmuModifications::Patches::ApplicationHelperPatch
  ApplicationHelper.send(:include, RedmineLmuModifications::Patches::ApplicationHelperPatch)
end

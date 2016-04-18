# encoding: utf-8
#

Redmine::Plugin.register :redmine_lmu_modifications do
  name 'Redmine LMU modifications plugin'
  author 'AlphaNodes GmbH'
  description 'Customizing for LMU Redmine'
  version '0.0.2'
  author_url 'https://alphanodes.com'
end

unless ApplicationHelper.included_modules.include? RedmineLmuModifications::Patches::ApplicationHelperPatch
  ApplicationHelper.send(:include, RedmineLmuModifications::Patches::ApplicationHelperPatch)
end

# Little hack for deface in redmine:
# - redmine plugins are not railties nor engines, so deface overrides are not detected automatically
# - deface doesn't support direct loading anymore ; it unloads everything at boot so that reload in dev works
# - hack consists in adding "app/overrides" path of all plugins in Redmine's main #paths
Rails.application.paths['app/overrides'] ||= []
Dir.glob("#{Rails.root}/plugins/*/app/overrides").each do |dir|
  Rails.application.paths['app/overrides'] << dir unless Rails.application.paths['app/overrides'].include?(dir)
end

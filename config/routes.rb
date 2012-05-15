#custom routes for this plugin
ActionController::Routing::Routes.draw do |map|
  map.connect "favorite_projects/:action", :controller => "favorite_projects"
end

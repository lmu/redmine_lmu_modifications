module FavoriteProjectsHelper
  # include ProjectsHelper
  
  def favorite_tag(object, user, options={})
    return '' unless user && user.logged? && user.member_of?(object)
    favorite = FavoriteProject.favorite?(object.id, user.id)
    url = {:controller => 'favorite_projects',
           :action => (favorite ? 'unfavorite' : 'favorite'),
           :project_id => object.id}
    link = link_to(image_tag(favorite ? 'fav.png' : 'fav_off.png', :style => 'vertical-align: middle;'),
                    url,
                    :remote => true)
                    
    content_tag("span", link, :id => "favorite_project_#{object.id}").html_safe
  end

  # Returns the css class used to identify watch links for a given +object+
  def favorite_css(objects)
    objects = Array.wrap(objects)
    id = (objects.size == 1 ? objects.first.id : 'bulk')    
    "#{objects.first.class.to_s.underscore}-#{object.id}-favorite"
  end
  
  def favorite_project_modules_links(project)
    links = []
    menu_items_for(:project_menu, project) do |node|
       links << link_to(extract_node_details(node, project)[0], extract_node_details(node, project)[1]) unless node.name == :overview
    end
    links.join(", ").html_safe
  end
  
end

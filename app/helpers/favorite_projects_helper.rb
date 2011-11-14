module FavoriteProjectsHelper
  # include ProjectsHelper
  
  def favorite_tag(object, user, options={})
    return '' unless user && user.logged? && user.member_of?(object)
    favorite = FavoriteProject.favorite?(object.id, user.id)
    url = {:controller => 'favorite_projects',
           :action => (favorite ? 'unfavorite' : 'favorite'),
           :project_id => object.id}
    link = link_to(image_tag(favorite ? 'fav.png' : 'fav_off.png', :style => 'vertical-align: middle;'),
                    url)
                    
    content_tag("span", link)
  end

  def favorite_link(object, user)

  end

  # Returns the css class used to identify watch links for a given +object+
  def favorite_css(object)
    "#{object.class.to_s.underscore}-#{object.id}-watcher"
  end
  
  def favorite_project_modules_links(project)
    links = []
    return
    menu_items_for(:project_menu, project) do |node|
       links << link_to(extract_node_details(node, project)[0], extract_node_details(node, project)[1]) unless node.name == :overview
    end
    links.join(", ")
  end
  
end

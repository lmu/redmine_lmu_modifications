# encoding: utf-8
#

# require_dependency 'application_helper'

module RedmineLmuModifications
  module Patches
    module ApplicationHelperPatch
      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)
        base.class_eval do
          alias_method_chain :page_header_title, :breadcrumb
        end
      end

      module InstanceMethods
        def short_header_title
          h(Setting.app_title)
        end

        def page_header_title_with_breadcrumb
          unless @project.nil? || @project.new_record?
            b = []
            ancestors = (@project.root? ? [] : @project.ancestors.visible.to_a)
            if ancestors.any?
              root = ancestors.shift
              b << link_to_project(root, { jump: current_menu_item }, class: 'root')
              if ancestors.size > 2
                b << "\xe2\x80\xa6"
                ancestors = ancestors[-2, 2]
              end
              b += ancestors.collect { |p| link_to_project(p, { jump: current_menu_item }, class: 'ancestor') }
            end
            b << h(@project)
            b.join(" \xc2\xbb ").html_safe
          end
        end
      end
    end
  end
end

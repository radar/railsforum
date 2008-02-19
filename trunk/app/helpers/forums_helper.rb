module ForumsHelper
    def breadcrumb(forum)
    breadcrumb = ""
    forum.parent.nil? ? breadcrumb = "-> " + link_to(forum.title, forum_path(forum)) : breadcrumb += " #{breadcrumb(forum.parent)} -> " + link_to(forum.title, forum_path(forum))
  end
end

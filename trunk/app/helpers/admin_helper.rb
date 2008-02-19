module AdminHelper
  def selected(name)
    if (params[:controller] == "admin/index" && name == "index") ||
       (params[:controller] == "admin/accounts" && name == "users") ||
       (params[:controller] == "admin/ranks" && name == "ranks") ||
       (params[:controller] == "admin/styles" && name == "styles")
      'selected'
    end
  end
end

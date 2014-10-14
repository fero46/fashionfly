module Backend::BackendHelper

  def activate items
    for item in items
      return 'active'  if controller.controller_path == "backend/#{item}"
    end
    ''
  end

  
end
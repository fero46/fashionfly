# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Fashionfly::Application.initialize!

ActionView::Base.field_error_proc = Proc.new do |html_tag, instance| 
  if html_tag =~ /<label/
    %|<div class="fieldWithErrors">#{html_tag} <span class="error">#{[instance.error_message].join(', ')}</span></div>|.html_safe
  else
    html_tag
  end
end

Lit.init.cache

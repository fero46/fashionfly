module StaticHelper
  def render_static_scope_page name
    if @scope.page(name).present?
      content_tag 'div', class: 'container whitebox' do 
        concat content_tag('h1', @scope.page(name).title) if @scope.page(name).title.present?
        concat simple_format @scope.page(name).body
      end
    else
      content_tag 'div', '',id: name, style: 'display:none'
    end
  end

end

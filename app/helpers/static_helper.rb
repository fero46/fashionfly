# frozen_string_literal: true

module StaticHelper
  def render_static_scope_page(name)
    if @scope.page(name).present?
      content_tag 'div', class: 'container' do
        content_tag 'div', class: 'white_box' do
          concat content_tag('h1', @scope.page(name).title) if @scope.page(name).title.present?
          concat simple_format @scope.page(name).body
        end
      end
    else
      content_tag 'div', '', id: name, style: 'display:none'
    end
  end
end

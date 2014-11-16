FashionFlyEditor::Category.class_eval do
  belongs_to :scope


  def create_slug object
    return object.name if object.class.name != FashionFlyEditor::Category.name
    parent = object.parent
    parent_slug = create_slug(parent) if parent.present?
    parent_slug = parent_slug.present? ? parent_slug+ "_"  : ''
    return parent_slug + clean_name(object.name).try(:downcase)
  end
end
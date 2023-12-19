# frozen_string_literal: true

namespace :seed do
  namespace :icons do
    desc 'Replace Category Icons with the new one'
    task replace: :environment do
      icons = Dir["#{Rails.root.join('db', 'icons')}/*"]
      icons.each do |icon|
        basename = File.basename(icon, '.png')
        id = basename.split('_')[0]
        basename = basename.gsub("#{id}_", '')
        myicon = Icon.where(id: id).first_or_initialize
        myicon.name = basename
        myicon.image = File.new(icon)
        myicon.save
      end
    end
    desc 'Assign Icons to Category by order'
    task assign: :environment do
      scopes = Scope.all
      scopes.each do |scope|
        main_categories = scope.categories.where(category_id: nil)
        children = []
        main_categories.each do |main_category|
          main_category.categories.each { |c| children << c }
        end
        icons = Icon.all
        22.times do |x|
          icon = icons[x]
          children[x].icons.destroy
          Category.where(id: children[x].id).first.icons << icon
        end
      end
    end
  end
end

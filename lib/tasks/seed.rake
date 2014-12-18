namespace :seed do
  namespace :icons do

    desc 'Replace Category Icons with the new one'
    task :replace => :environment do
      icons = Dir[Rails.root.join('db','icons').to_s+"/*"]
      for icon in icons
        basename = File.basename(icon, ".png")
        id = basename.split('_')[0]
        basename = basename.gsub("#{id}_", '')
        myicon = Icon.where(id: id).first_or_initialize
        myicon.name = basename
        myicon.image = File.new(icon)
        myicon.save
      end
    end
    desc 'Assign Icons to Category by order'
    task :assign => :environment do
      scopes = Scope.all
      for scope in scopes
        main_categories = scope.categories.where(:category_id => nil)
        children = []
        for main_category in main_categories
          main_category.categories.each {|c| children << c}
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
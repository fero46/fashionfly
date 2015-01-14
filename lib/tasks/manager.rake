namespace :manager do
  namespace :util do
    desc 'Replace Category Icons with the new one'
    task :copy, [:from,:to]  => :environment  do |t, args|
      source = Scope.find(args.from)
      target = Scope.find(args.to)
      target.categories.destroy_all
      copy_categories(source, target)
    end


    def copy_categories source, target
      for category in source.categories.where(main_taxon: true)
        duplicated = duplicate_category(category, target)
        duplicated.save!
      end
    end

    def duplicate_category(category, new_scope)
      copy = Category.new(name: category.name,
                          main_taxon: category.main_taxon,
                          position: category.position,
                          published: category.published,
                          leaf: category.leaf)
      copy.scope_id = new_scope.id
      icons = category.icons
      if icons.present?
        for icon in icons
          copy.icons << icon
        end
      end
      categories = category.categories
      if categories.present?
        for child_category in categories
          copy.categories << duplicate_category(child_category, new_scope)
        end
      end
      copy
    end

  end
end
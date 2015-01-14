namespace :manager do
  namespace :util do
    desc 'Replace Category Icons with the new one'
    task :copy, [:from,:to]  => :environment  do |t, args|
      source = Scope.find(args.from)
      target = Scope.find(args.to)
      target.categories.destroy_all
      target.outfit_categories.destroy_all
      copy_categories(source, target)
      copy_outfit_categories(source, target)
    end


    def copy_categories source, target
      for category in source.categories.where(main_taxon: true)
        duplicated = duplicate_category(category, target)
        duplicated.save!
      end
    end

    def copy_outfit_categories source, target
      for category in source.child_outfit_categories
        duplicate_outfit_category(category, target, target)
      end
    end

    def duplicate_outfit_category category, parent, target
      copy = FashionFlyEditor::Category.new(name: category.name,
                                            parent_id: parent.id,
                                            parent_type: parent.class.name)
      copy.save
      if category.categories.present?
        for child_category in category.categories
          duplicate_outfit_category(child_category, copy, target)
        end
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
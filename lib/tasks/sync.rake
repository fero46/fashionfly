# frozen_string_literal: true

namespace :db do
  namespace :sync do
    desc 'Sync from Dollibar to Spree'
    task start: :environment do
      importer = ZanoxImporter.new
      importer.run
    end

    task count: :environment do
      importer = ZanoxImporter.new
      importer.count
    end

    task update_categries: :environment do
      importer = ZanoxImporter.new
      importer.update_categories
    end
  end
end

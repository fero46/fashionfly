app_path = File.expand_path(File.join(File.dirname(__FILE__)))
require 'clockwork'
require "#{app_path}/config/boot"
require "#{app_path}/config/environment"

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  # handler receives the time when job is prepared to run in the 2nd argument
  # handler do |job, time|
  #   puts "Running #{job}, at #{time}"
  # end
  sleep(1)
  every(1.minute, 'Import Check') {ImportPrepareWorker.prepare}
  every(6.hours, 'Blog Update'){EntryWorker.run}
  every(1.day, 'AffiliateWorker', at: '03:00'){AffiliateWorker.run}
  every(1.day, 'Trends Check', at: '06:00'){TrendCheckWorker.check}
  every(1.day, 'Brand Category', at: '00:00'){BrandCategoryWorker.run}
  every(1.day, 'Sitemap', at: '05:00') do
    Dir.chdir Rails.root
    `RAILS_ENV=#{Rails.env} bundle exec rake sitemap:generate`
  end
  every(1.day, 'Clean Up', at: '01:00'){CleanCollectionWorker.run}
  every(1.day, 'Random Order', at: '03:00'){RandomProductOrderWorker.run}
end

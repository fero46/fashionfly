class EntryWorker
  include Sidekiq::Worker

  def perform

    User.where(is_blogger: true).find_in_batches(batch_size: 500) do |group|
      group.each { |user| user.update_blogging_feed }
    end

  end

  def self.run
    perform_async()
  end

end

class Feed < ActiveRecord::Base
  validates :user_id, presence: true
  serialize :value
  has_many :entries
  belongs_to :user
  after_save :recreate_entries

  def recreate_entries
    my_entries = value.entries
    for my_entry in my_entries
      entry = Entry.where(feed_id: self.id, entry_identifier: my_entry.entry_id).first_or_initialize
      if entry.published != my_entry.published
        entry.title = my_entry.title
        entry.url=my_entry.url
        entry.published=my_entry.published
        entry.author=my_entry.author
        entry.entry_identifier=my_entry.entry_id
        entry.summary=my_entry.summary
        entry.content=my_entry.content
        entry.tag_list = my_entry.categories.join(',')
        entry.scope_id = self.user.scope_id
        entry.user_id = self.user.id
        entry.save
      end
    end
  end
end

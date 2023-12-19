# frozen_string_literal: true

class Visit < ActiveRecord::Base
  has_many :visitables

  def self.run(visitable, user, cookie)
    return if visitable.blank?

    user_id = user.present? ? user.id : nil
    VisitWorker.goto(visitable.id, visitable.class.name, user_id, cookie)
  end

  def self.see(visitable, user_id, cookie)
    return if visitable.blank?

    begin
      if user_id.present? && cookie.present?
        visitable.visits.where(cookie: '', user_id: user_id).first.destroy
        Visit.where(cookie: cookie).update_all(cookie: '', user_id: user_id)
        cookie = ''
      end
      cookie = '' if cookie.blank?
      visitable.visits.where(cookie: cookie, user_id: user_id).first_or_create!
    rescue StandardError
      # Mir egal wenn ein Visit nicht registriert werden sollte.
    end
    Visit.dedupe(visitable.visits) # Doppelte Visits die sich einschleichen löschen.
  end

  def self.dedupe(visits)
    grouped = visits.group_by do |model|
      [model.user_id,
       model.cookie,
       model.visitable_id,
       model.visitable_type]
    end
    grouped.each_value do |duplicates|
      duplicates.shift
      duplicates.each(&:destroy)
    end
  end
end

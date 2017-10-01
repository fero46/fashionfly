class VisitWorker < ActiveJob::Base

  def perform(visitable_id, visitable_type, user_id, cookie)
    klazz = Object.const_get(visitable_type)
    visitable = klazz.find(visitable_id)
    Visit.see(visitable, user_id, cookie)
    visitable.update(visits_count: visitable.visits.count) if visitable.present?
  end


  def self.goto(visitable_id, visitable_type, user_id, cookie)
    perform_later(visitable_id, visitable_type, user_id, cookie)
  end


end

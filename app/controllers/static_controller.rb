# frozen_string_literal: true

class StaticController < ScopeController
  def faq
    render 'static', locals: { name: '__faq__page__' }
  end

  def privacy
    render 'static', locals: { name: '__privacy__page__' }
  end

  def disclaimer
    render 'static', locals: { name: '__disclaimer__page__' }
  end

  def impress
    render 'static', locals: { name: '__impress__page__' }
  end

  def about
    render 'static', locals: { name: '__about__page__' }
  end

  def terms
    render 'static', locals: { name: '__terms__page__' }
  end

  def team; end
end

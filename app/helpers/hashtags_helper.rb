# frozen_string_literal: true

module HashtagsHelper
  def linkify_hashtags(hashtaggable_content)
    regex = SimpleHashtag::Hashtag::HASHTAG_REGEX
    hashtagged_content = hashtaggable_content.to_s.gsub(regex) do
      link_to(::Regexp.last_match(0), hashtag_path(::Regexp.last_match(2)), { class: :hashtag })
    end
    hashtagged_content.html_safe
  end

  def render_hashtaggable(hashtaggable)
    klass        = hashtaggable.class.to_s.underscore
    view_dirname = klass.pluralize
    partial      = klass
    render "#{view_dirname}/#{partial}", { klass.to_sym => hashtaggable }
  end
end

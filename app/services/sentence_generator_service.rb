# frozen_string_literal: true

class SentenceGeneratorService
  def initialize
    @generators = []
    add 'de', GermanSentenceGenerator
  end

  def generator(locale)
    @generators.each do |generator|
      return generator[:class].new(generator[:locale]) if generator[:locale] == locale
    end
    GenericSentenceGenerator.new(locale)
  end
end

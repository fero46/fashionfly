class SentenceGeneratorService

  def initialize
    @generators = []
    add 'de', GermanSentenceGenerator
  end

  def generator locale
    for generator in @generators
      return generator[:class].new(generator[:locale]) if generator[:locale] == locale
    end
    GenericSentenceGenerator.new(locale)
  end

end
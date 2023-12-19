# frozen_string_literal: true

require 'tokenizer'
require 'unicode'

# Dieser Satzgenerator ist ein Einfacher Generator für SEO Texte.
# Da die Anzahl der Produkte zu Groß für handische Anpassung der Texte
# ist. Bedienen wir uns mit hilfe einer Wörter Datenbank und der Attributen eines
# Produkts und generieren abweichende Beschreibungen, der schon vorhandene Beschreibung
class GenericSentenceGenerator
  def initialize(locale)
    @locale = locale
    @tokenizer = Tokenizer::Tokenizer.new
  end

  def generate(product_id)
    product = Product.find(product_id)
    scope = product.scope
    return unless scope.locale == @locale

    brand = product.brand
    color_feeling = product.colorization.words.where(scope_id: scope.id).first
    color_word = product.colorization.color_words.where(scope_id: scope.id).first
    category = product.categories.where(!:category_id.nil?).order('RAND()').first
    map = { brand: brand, color_word: color_word,
            category: category, color_feeling: color_feeling }
    check(map)
    string_from_rule = rule(map)
    description = "#{string_from_rule}#{product.description}"
    synonym_replace(scope, description)
  end

  # TODO: für die spätere Version wird statt eines Wort ersätzers
  # Ein komplexeres Tool benötigt. Um Gramatikalische Eigenschaften einer Sprache zu
  # unterstützen
  def synonym_replace(scope, text)
    tokens = @tokenizer
    rejoined_text = tokens.join(' ') # Wurde gemacht damit ! , . icht direkt am Word sind.
    words = scope.words
    replacing_words = []
    words.each do |word|
      replacer << word if rejoined_text.include?(word.value)
    end

    replacing_words.each do |replacing_word|
      word = replacing_word.synonyms_words.sample
      next unless word.present?

      orig = replacing_word.value
      replacing = word.value
      text.gsub! orig, replacing
    end

    special_char = ['!', ',', '.', '?', ':', ';']

    # revert the result from tokenizer
    special_char.each do |char|
      text.gsub! " #{char} ", "#{char} "
    end
    Unicode.capitalize(text)
  end

  def check(map)
    map.each { |k, _v| raise ArgumentError, "#{k} is not set" }
  end

  def rule(map)
    method(sentences.sample, map).call
  end

  # Liefert in der Implementierende version eine Array von Symbolen.
  # Jeder Symbol steht für eine Method der instance von dieser geerbten Klasse
  # Diese Methoden liefern ein String zurück und haben ein map als Parameter.
  def sentences
    raise NotImplementedError, "Not implemented for locale #{@locale}"
  end
end

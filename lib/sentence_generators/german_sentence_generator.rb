class GermanSentenceGenerator < GenericSentenceGenerator


  def sentences
    [:version1, :version2, :version3, :version4]
  end

  def version1 map
    "#{map[:color_feeling].value} #{map[:color_word].descriptive} #{map[:category].name} von #{map[:brand].name}"
  end

  def version2 map
    "#{map[:color_feeling].value} #{map[:category].name} #{map[:color_word].sentence_part} von #{map[:brand].name}"
  end

  def version3 map
    "von #{map[:brand].name} : #{map[:color_feeling].value} #{map[:category].name} #{map[:color_word].sentence_part}"
  end

  def version4 map
    "von #{map[:brand].name} : #{map[:color_feeling].value} #{map[:color_word].descriptive} #{map[:category].name}"
  end

end
# frozen_string_literal: true

class ExtendedReklamActionImporter < ReklamActionImporter
  def find_category(node)
    sexes = nil
    cat = ''
    switch_to_detail = false
    node.children.each do |subnode|
      if subnode.name ==  MAIN_CAT || subnode.name == SUBCAT
        cat = "#{cat} - " if cat != ''
        cat = "#{cat}#{subnode.content}".strip
        switch_to_detail = true
      end
      if subnode.name == 'Categories'
        subnode.children.each do |catigo_node|
          cat = '' if switch_to_detail
          cat = "#{cat} - " if cat != ''
          cat = "#{cat}#{catigo_node.content}".strip
          switch_to_detail = false
        end
      end
      if subnode.name == FullDesc
        content = subnode.content
        sexes = if content.include? 'bayan'
                  'BAYAN'
                elsif content.include? 'erkek'
                  'ERKEK'
                end
      end
      next unless subnode.name == GENDER

      content = subnode.content
      case content
      when 'M', 'm'
        sexes = 'ERKEK'
      when 'F', 'f'
        sexes = 'BAYAN'
      end
    end
    cat = "#{sexes} - #{cat}" if sexes.present?
    cat.strip
  end
end

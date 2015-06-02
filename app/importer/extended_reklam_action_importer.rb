class ExtendedReklamActionImporter < ReklamActionImporter


  def find_category node
    sexes = nil
    cat = ""
    for subnode in node.children
      if subnode.name ==  MAIN_CAT || subnode.name == SUBCAT
        cat = "#{cat} - " if cat != ""
        cat = "#{cat}#{subnode.content}"
      end
      if subnode.name == FullDesc
        content = subnode.content
        if content.include? "bayan"
          sexes = "BAYAN"
        elsif content.include? "erkek"
          sexes = "ERKEK"
        else
          sexes = nil
        end
      end
      if subnode.name = GENDER
        content = subnode.content
        if content == "M" || content == "m"
          sexes = "ERKEK"
        elsif content == "F" || content == "f"
          sexes = "BAYAN"
        end
      end
      if subnode.name == "Categories"
        for catigo_node in subnode.children
          cat = "#{cat} - " if cat != ""
          cat = "#{cat}#{catigo_node.content}"
        end
      end
    end
    cat = "#{sexes} - #{cat}" if sexes.present?
    cat
  end


end

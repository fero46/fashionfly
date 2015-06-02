class MomodaImporter < ReklamActionImporter

  def product_remote_image values
    values[IMAGES].gsub('100/100', '1000/1000').
                  gsub('200/200', '1000/1000').
                  gsub('300/300', '1000/1000').
                  gsub('400/400', '1000/1000').
                  gsub('500/500', '1000/1000').
                  gsub('600/500', '1000/1000').
                  gsub('700/500', '1000/1000').
                  gsub('800/800', '1000/1000') if values[IMAGES].present?
  end 

end

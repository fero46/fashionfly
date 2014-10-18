class MappingService

  def initialize affiliate
    @affiliate = affiliate
  end

  def all_categories
    parser = eval(@affiliate.importer.to_s).new(@affiliate)
    parser.categories
  end

end
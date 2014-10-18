 #encoding: utf-8 
require 'xml'
require 'fileutils'
require 'open-uri'

class GenericImporter

  def initialize affiliate
    @affiliate = affiliate
  end

  def categories
    categories = []
    document.root.children.each do |tag|
      if tag.name == @affiliate.item_tag
        tag.children.each do |t|
          categories << t.content if t.name == @affiliate.category_tag
        end
      end
    end
    categories.uniq
  end

private

  def document
    @document if @document.present?
    xml = open(@affiliate.file.path) {|f| f.read }
    source = XML::Parser.string(xml)
    @document = source.parse
  end

end
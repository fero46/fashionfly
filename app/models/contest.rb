class Contest < ActiveRecord::Base
  belongs_to :scope
  mount_uploader :banner, ImageUploader

  validates :title,  presence: true
  validates :body,   presence: true
  validates :banner, presence: true
  validates :slug, presence: true, uniqueness: true

  before_validation :update_slug


  def update_slug
    self.slug = create_slug
  end

  def create_slug
    myslug = clean_name(title)
    appendix="_"
    counter = 0
    builded_slug = myslug
    while Contest.where(slug: builded_slug).first.present?
      counter+=1
      builded_slug="#{myslug}#{appendix}#{counter}"
    end
    builded_slug
  end

private
    def clean_name name
      return "" if name.blank?
      name.gsub('ö', 'oe').gsub('ü', 'ue').gsub('ä', 'ae').gsub('ß','ss').gsub('%', '').gsub(' ','_').gsub('&','und')
    end
end
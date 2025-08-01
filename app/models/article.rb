class Article < ApplicationRecord
  belongs_to :articable, polymorphic: true, optional: true
  belongs_to :keyword, optional: true
  has_many :section_highlights, dependent: :delete_all
  belongs_to :author, optional: true
  validates :name, :short_description, :image, presence: true
  validates :name, uniqueness: true

	attr_accessor :hashtags_names, :the_note

  has_and_belongs_to_many :hashtags, uniq: true
  before_save :associate_tags
  before_create :to_slug
  
  belongs_to :user, optional: true
  has_many :article_relationships, dependent: :delete_all
  has_many :hits, dependent: :delete_all
  has_many :images, dependent: :delete_all
  accepts_nested_attributes_for :images, reject_if: proc { |attributes| attributes['src'].blank? }, allow_destroy: true

  def to_param
    slug
  end
  def html_note 
    self.plain_text.prepend("<p>")
    self.plain_text << "</p>"
    self.plain_text.gsub(/\n/, '<br>')
  end
  def raw_note 
    ActionController::Base.helpers.raw(self.note)
  end
  def total_hits_in_current_month
    self.hits.where(created_at: 1.months.ago..Time.now).sum(:number)
  end
  # def section 
  #   if self.articable
  #     self.articable.name 
  #   else 
  #     return nil 
  #   end
  # end
  def section_color 
    if self.articable
      self.articable.color
    else
      return nil
    end
  end

  private
    def associate_tags
      # if self.note_old
      #   self.note_old = self.note_old + " "
      # else
      #   self.note_old = " "
      # end
      if hashtags_names
        self.hashtags.delete_all
        hashtags_names.split(", ").each do |name|
          self.hashtags << Hashtag.find_or_create_by(name)
        end
      end
    end

    def to_slug
      #strip the string
      name = self.name.strip
      slug = I18n.transliterate(name)
      slug = slug.scan(/([[:alnum:]]+)/).join('_')
      slug = slug.length < 1 ?  SecureRandom.hex : slug
      slug = slug.downcase
      self.slug =  slug
      self.friendly_slug =  slug
    end

    

    def set_note
      if the_note
        self.note = the_note
      end
    end
end

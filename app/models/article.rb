class Article < ApplicationRecord
  belongs_to :articable, polymorphic: true, optional: true
  belongs_to :keyword, optional: true
  has_many :section_highlights, dependent: :delete_all
  belongs_to :author, optional: true
  validates :name, :short_description, :image, presence: true, uniqueness: { scope: :name,
    message: "Ya existe una nota con ese nombre" }

	attr_accessor :hashtags_names, :the_note

  has_and_belongs_to_many :hashtags, uniq: true
  before_save :associate_tags, :to_slug
  
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
      if hashtags_names
        self.hashtags.delete_all
        hashtags_names.split(", ").each do |name|
          self.hashtags << Hashtag.find_or_create_by( name: name )
        end
      end
    end

    def to_slug
      #strip the string
      ret = self.name.strip

      #blow away apostrophes
      ret.gsub! /['`]/,""

      ret.gsub! /[.]/,""
      # @ --> at, and & --> and
      ret.gsub! /\s*@\s*/, " en "
      ret.gsub! /\s*&\s*/, " y "

      #replace all non alphanumeric, underscore or periods with underscore
       ret.gsub! /\s*[^A-Za-z0-9ÁáÉéÍíÓóÚú\.\-]\s*/, '-'  

       #convert double underscores to single
       ret.gsub! /_+/,"-"

       #strip off leading/trailing underscore
       ret.gsub! /\A[_\.]+|[_\.]+\z/,""

      # Revisar slugs repetidos 

      self.slug =  ret
    end

    

    def set_note
      if the_note
        self.note = the_note
      end
    end
end

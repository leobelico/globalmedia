xml.instruct! :xml, :version=>"1.0"
xml.tag! 'urlset', 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9',
         'xmlns:news' => 'http://www.google.com/schemas/sitemap-news/0.9' do
  @items.each do |item|
    xml.url do
      xml.loc 'https://www.globalmedia.mx/articles/' + item.slug
      xml.tag!("news:news") do
        xml.tag!("news:publication") do
          xml.tag!("news:name", 'GlobalMedia')
          xml.tag!("news:language", 'es')
        end
        xml.tag!("news:publication_date", item.published_at.to_date)
        xml.tag!("news:title", item.name)
        xml.tag!("news:keywords", item.meta_tags)
      end
    end
  end
end

xml.instruct! :xml, :version=>"1.0"
xml.tag! 'urlset', 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  @items.each do |item|
    xml.url do
      xml.loc item.loc
      xml.lastmod item.lastmod
      xml.changefreq item.changefreq
      xml.priority item.priority
    end
  end
end
require 'open-uri'
require 'nokogiri'

module Services
  class GoogleSearch
    def self.get_result(keyword)
      
      results = []
      escape_keyword = CGI.escape(keyword)
  
      url = "http://www.google.co.jp/search?ie=UTF-8&oe=UTF-8&q=#{escape_keyword}"
      doc = Nokogiri.HTML(open(url))
  
      doc.search("div#search ol li").each_with_index do |li, idx|
        href = ""
        html = ""
        link = ""
  
        li.search("h3 a").each do |alink|
          cls = alink.attribute("class")
          
          next if !cls.nil?

          href = alink.attribute("href")
          URI.parse(href).query.split(/&/).each do |str|
            strs = str.split(/=/)
            link = strs[1] if strs[0] == "q"
          end
          html = alink.inner_html
        end
 

        next if "#{href}" !~ /^\/url/
  
        result = {:idx => idx + 1, :domain => link.split("/")[2], :link => link, :html => html}
        results.push(result)
      end
  
      return results
    end
  end
end

class LocalSkiReport::Scraper
    
    def self.get_page(url)
        html = open(url)
        Nokogiri::HTML(html)    
    end
   
    def self.scrap_resorts_page(state_url)
        url = "http://www.onthesnow.com/#{state_url}/skireport.html"
        doc = self.get_resorts_page(url)
        
        binding.pry
    end
    
    def self.scrap_report_page(report_url)
        doc = self.get_page(report_url)
    end
    
end
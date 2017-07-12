class   LocalSkiReport::Resort
    attr_accessor :name, :url, :location, :lifts, :reports
    
    @@all = []
    
    def initialize
        @reports = []
        @@all << self
    end
    
    def self.create(html)
        new_resort = self.new
        new_resort.name = html.css('td div.name').text
        new_resort.url = html.css('div.name a').first['href']
        new_resort.location html.css('td div.rRegion').text
        new_resort.lifts =  html.css('td')[4].text.gsub("/","")
        new_resort
    end
    
    def self.all
        @@all
    end
    
    def self.clear
        @@all.clear
    end
    
    
end
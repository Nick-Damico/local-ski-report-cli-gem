class   LocalSkiReport::Resort
    attr_accessor :name, :url, :location, :lifts, :reports
    
    @@all = []
    
    def initialize(name, url, location, lifts)
        @reports = []
        @name = name
        @url = url
        @location = location
        @lifts = lifts
        @@all << self
    end
    
    def self.all
        @@all
    end
    
    def self.clear
        @@all.clear
    end
    
    def self.create(html)
        name = html.css('td div.name').text
        url = html.css('div.name a').first['href']
        location = html.css('td div.rRegion').text
        lifts =  html.css('td')[4].text.split("/").last
        self.new(name, url, location, lifts)
    end
    
    def add_report(report)
        report.resort = self
        self.reports << report
    end
    
end
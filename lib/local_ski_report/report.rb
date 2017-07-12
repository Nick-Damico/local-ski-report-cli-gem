class LocalSkiReport::Report
    attr_accessor :date, :url, :status, :new_snow, :base, :lifts_open, :resort
    
    @@all = []
    
    def initialize
        @@all << self
    end
    
    def self.all
        @@all
    end
    
    def self.clear
        @@all.clear
    end
    
    def self.create(html)
        report = self.new
        report.date = html.css('div.lUpdate').text
        report.url =  html.css('td')[3].css('a').first['href']
        status = html.css('td')[1].css('div').first['class'].split(" ").pop
        report.status = report.get_status(status)
        report.new_snow = html.css('td')[2].css('b')[0].text
        report.base = html.css('td')[3].css('b')[0].text
        lift_open = html.css('td')[4].text.split("/").first
        lift_open == "" ? report.lifts_open = 0 : report.lifts_open = lift_open
       
        report
    end
    
    def get_status(state)
        case state
        when "stateD1"
            "Open"
        when "stateD2"
            "Closed"
        else
            "Weekends Only"
        end
    end
    
end
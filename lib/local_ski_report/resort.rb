class  LocalSkiReport::Resort
    attr_accessor :name, :location, :l_update, :snowfall, :url, :base_depth, :lifts, :open_acreage, :reports

    @@all = []

    def initialize(args)
        @name = args[:name]
        @location = args[:location]
        @snowfall = args[:snowfall]
        @url = args[:url]
        @base_depth = args[:base_depth]
        @open_acreage = args[:open_acreage]
        @lifts = args[:lifts]
        @l_update = args[:l_update]
        @@all << self
    end

    def add_report(report)
        report.resort = self
        self.reports << report
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

    def self.find_by_location(location)
        all.select { |resort| resort.location == location }
    end

    def self.sort_by_lifts_desc
        self.all.sort { |x, y| y.lifts.to_i <=> x.lifts.to_i }
    end

end

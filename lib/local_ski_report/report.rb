class LocalSkiReport::Report
    attr_accessor :date, :resort, :url, :lifts_open, :new_snow, :base
    
    @@all = []
    
    def initialize
        @@all << self
    end
    
    def get_brief_report
    end
    
    def get_full_report
    end
    
    def self.all
        @@all
    end
    
    def self.clear
        @@all.clear
    end
    
end
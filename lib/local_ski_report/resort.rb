class   LocalSkiReport::Resort
    attr_accessor :name, :url, :location, :lifts, :reports
    
    @@all = []
    
    def initialize
        @reports = []
        @@all << self
    end
    
    def self.all
        @@all
    end
    
    def self.clear
        @@all.clear
    end
    
    
end
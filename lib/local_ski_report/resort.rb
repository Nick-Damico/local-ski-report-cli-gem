class   LocalSkiReport::Resort
    attr_accessor :name, :url, :location, :lifts
    
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
    
    
end
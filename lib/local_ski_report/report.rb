class LocalSkiReport::Report
    attr_accessor :date, :resort, :url, :lifts_open, :new_snow, :base
    
    def initialize(date)
        @date = date
    end
    
end
# Our CLI Controller
class LocalSkiReport::CLI
    
    STATES_WITH_RESORTS = {
        :new_england => ["Connecticut", "Maine", "Massachusetss", "New Hampshire", "Rhode Island", "Vermont"],
        :mid_atlantic => ["Maryland", "New Jersey", "New York", "Pennsylvania"],
        :southeast => ["Alabama", "Georgia", "North Carolina", "Tennessee", "Virginia", "West Virginia"],
        :midwest => ["Illinois", "Indiana", "Iowa", "Kansas", "Michigan", "Minnesota","Missouri", "North Dakota", "Ohio", "South Dakota", "Wisconsin"],
        :rocky_mountains => ["Arizona", "Colorado", "Idaho", "Montana", "New Mexico", "Texas", "Utah", "Wyoming"],
        :west_coast => ["Alaska", "California", "Nevada", "Oregon", "Washington"]
    }
    
    def call
        puts "Find your Local Ski Report:"
        puts "What State is your Ski Resort in? "
        
    end
    
end
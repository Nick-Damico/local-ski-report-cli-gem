# Our CLI Controller
class LocalSkiReport::CLI
    
    STATES_WITH_RESORTS = [
        { :midwest => ["Illinois", "Indiana", "Iowa", "Kansas", "Michigan", "Minnesota", "Missouri", "Ohio","Wisconsin"] },
        { :northeast => ["Connecticut", "Maine", "Massachusets", "New Hampshire", "New Jersey", "New York", "Pennsylvania", "Rhode Island", "Vermont"] },
        { :northwest => ["Alaska", "Idaho", "Oregon", "Washington"] },
        { :rockies => ["Colorado", "Montana", "New Mexico", "Utah", "Wyoming"] },
        { :southeast => ["Alabama", "Georgia", "Maryland", "North Carolina", "Tennessee", "Virginia", "West Virginia"] },
        { :west_coast => ["Arizona", "California", "Nevada"] }
    ]
    
    def call
        puts "Find your Local Ski Report:"
        list_regions
        puts "Which region would you like to check? type number: "
        x = gets.chomp.to_i
        list_states(x)
        puts "Which State would you like to check? type number: "
        selected_state = gets.chomp.to_i
        # This user Response will be used to make a request 
    end
    
    def list_regions
        i = 1
        STATES_WITH_RESORTS.each do |region|
            region.each_key do |k|
                puts "#{i}. #{k.to_s.gsub("_", " ").upcase}"
                i += 1
            end
        end
    end
    
    def list_states(user_request)
        STATES_WITH_RESORTS[user_request].each_value do |states|
            states.each_with_index { |state, i| puts "#{i+1}. #{state}" }
        end
    end
    
end
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
        greeting
        menu
        exit_msg
    end
    
    def greeting    
        puts "Welcome to Local Ski Report gem"
        puts "Find your Local Ski Report:"
    end
    
    def menu
        list_regions
        puts "Which region would you like to check? type number: "
        region_num = gets.chomp.to_i - 1
        
        list_states(region_num)
        puts "Which State would you like to check? type number: "
        state_num = gets.chomp.to_i - 1
        
        # Improve later with a look up method #find
        user_region = STATES_WITH_RESORTS[region_num].keys[0]  #Get :symbol name
        user_state = STATES_WITH_RESORTS[region_num][user_region][state_num] #Get users choosen State Regions Array
   
        list_resorts(user_state) #user_state will be used to direct Scraper to user requested state page.
   
        input = nil
        while input != "exit"
            puts "Type: 'more' to see detailed report, 'resort' to select New Resort, 'exit' to leave App."
            input = gets.strip.downcase
            case input
            when "resort"
                menu
            when "more"
                more_info
            else 
                puts "Not sure what you want, type 'resort' for a new search or 'exit'"
            end
        end
    end
    
    def more_info
        # Scrapper will get this info from site.
        puts "More info on selected resort..."
    end
    
    def list_resorts(state)
        LocalSkiReport::Scrapper(url)
        resorts = LocalSkiReport::Resort.all
        resorts.each_with_index { |r,i| puts "#{i+1}. #{r.name}" }
        puts "Select a Resort or Area for the latest Ski Report: "
        user_pick = gets.chomp.to_i - 1
        resort = resorts[user_pick]
            
        # Need this to be formatted in tabular data, try out Terminal-Table
        puts "#{resort.name} -- Location: #{resort.location} --  -- Status: #{resort.status}."
        
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
    
    def exit_msg
        puts "Check back later for latest Ski reports, "
        puts "Thanks for using Local Ski Reports gem."
    end
    
end
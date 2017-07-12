# Our CLI Controller
class LocalSkiReport::CLI
    
    attr_accessor :resort
    
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
        user_region = get_region(region_num) #gets region :key
        user_state = get_state(region_num, user_region, state_num) #gets state "string"

        resort_list = list_resorts(user_state) #user_state will be used to direct Scraper to user requested state page.
        puts "Select a Resort or Area for the latest Ski Report: "
        user_pick = gets.chomp.to_i - 1
        
        @resort = resort_list[user_pick]
        build_table
        
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
    
    def get_region(num)
        STATES_WITH_RESORTS[num].keys[0]
    end
    
    def get_state(reg_num, user_reg, st_num)
        STATES_WITH_RESORTS[reg_num][user_reg][st_num].downcase.gsub(" ", "-") #Get users choosen State Regions Array
    end
    
    def list_resorts(state)
        resorts = LocalSkiReport::Scraper.scrap_resorts_page(state)
        resorts.each_with_index { |r,i| puts "#{i+1}. #{r.name}" }
        resorts
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
    
    def more_info
        # Scrapper will get this info from site.
        puts "More info on selected resort..."
    end
    
    def build_table
        # Need to fix lifts/lifts_open
        # Alignment of cells might need tweeaked
        report = @resort.reports[0]
        rows = []
        rows << [resort.name, report.status, report.new_snow, report.base, "#{report.lifts_open}/#{resort.lifts}"]
        table = Terminal::Table.new :title => "Ski Report", :headings => ['Resort Name', 'Status', 'New Snow', 'Base Depth', 'Lifts Open'], :rows => rows
        puts table
    end
    
    def exit_msg
        puts "Check back later for latest Ski reports, "
        puts "Thanks for using Local Ski Reports gem."
    end
    
end
# Our CLI Controller
class LocalSkiReport::CLI
    
    attr_accessor :resort
    
    STATES_WITH_RESORTS = [
        { :midwest => ["Illinois", "Indiana", "Iowa", "Kansas", "Michigan", "Minnesota", "Missouri", "Ohio","Wisconsin"] },
        { :northeast => ["Connecticut", "Maine", "Massachusetts", "New Hampshire", "New Jersey", "New York", "Pennsylvania", "Rhode Island", "Vermont"] },
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
        puts "=" * 40
        puts "Welcome to Local Ski Report gem"
        puts "=" * 40
        puts "Let's Get Your Local Ski Report"
        puts " "
    end
    
    def menu
        region_num = self.select_region
        list_states(region_num)
        state_num = select_state
        
        user_region = get_key(region_num) 
        user_state = get_state(region_num, user_region, state_num) #gets state "string"
        
        resort_list = list_resorts(user_state) 
        select_resort(resort_list)
        
        display_table
        
        input = nil
        while input != "exit"
            puts "Type: 'more' for detailed report, 'new' for new search, 'exit' to Quit."
            input = gets.strip.downcase
            case input
            when "resort"
                menu
            when "more"
                more_info
            end
        end
    end
    
    def get_key(num)
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
    
    def select_region
        list_regions
        puts "-" * 40
        puts "Which region would you like to check? type number: "
        gets.chomp.to_i - 1
    end
    
    def select_resort(resorts_arr)
        puts "Select a Resort or Area for the latest Ski Report: "
        x = gets.chomp.to_i - 1
        @resort = resorts_arr[x]
    end
    
    def select_state
        puts "-" * 40
        puts "Which State would you like to check? type number: "
        gets.chomp.to_i - 1
    end
    
    def more_info
        url = @resort.url
        report = @resort.reports.first
        LocalSkiReport::Scraper.scrap_report_page(report, url)
        table = report.xt_report
        puts table
    end
    
    def display_table
        report = @resort.reports.first
        table = report.report(resort)        
        puts table
    end
    
    def exit_msg
        puts "Check back later for latest Ski reports, "
        puts "Thanks for using Local Ski Reports gem."
    end
    
end
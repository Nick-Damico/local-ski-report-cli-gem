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
    
    def initialize
        LocalSkiReport::Scraper.scrap_resorts_page("united-states")
    end
    
    def call
        greeting
        menu
        exit_msg
    end
  
    def menu
        region_num = select_region
        user_region = get_key(region_num) 
        separator(50)
        
        state_num = select_state(region_num, user_region)
        user_state = get_state(region_num, user_region, state_num) #gets state "string"
        separator(50)
        
        select_resort(user_state)
        display_report
        
        input = nil
        while input != "exit"
            puts "Type: 'more' for detailed report, 'new' for new search, 'exit' to Quit."
            input = gets.strip.downcase
            case input
            when "new"
                menu
            when "more"
                display_xt_report
            else
                puts "Invalid command entered."
            end
        end
    end
    
    def greeting    
        separator(40)
        puts "Welcome to Local Ski Report gem"
        separator(40)
        puts "Let's Get Your Local Ski Report"
        puts " "
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
    
    def list_states(num)
        STATES_WITH_RESORTS[num].each_value do |states|
            states.each.with_index(1) { |state, i| puts "#{i}. #{state}" }
        end
    end
    
    def select_region
        list_regions
        separator(50)
        puts "Which region would you like to check? type number: "
        input =  gets.chomp.to_i - 1
        if input.between?(0, STATES_WITH_RESORTS.size - 1)
            input
        else
            puts "Invalid number. Please choose a number between 1 - #{STATES_WITH_RESORTS.size}: "
            select_region
        end
    end
    
    def select_resort(state)
        resorts_arr = list_resorts(state)
        separator(50)
        puts "Select a Resort or Ski-Area for the latest Ski Report: "
        input = gets.chomp.to_i - 1
        if input.between?(0, resorts_arr.size - 1)
            @resort = resorts_arr[input]
        else
            separator(60)
            puts "Invalid Choice. Please choose a Resort # between 1 - #{resorts_arr.size}."
            separator(60)
            select_resort(state)
        end
    end
    
    def select_state(region_num, region_key)
        list_states(region_num)
        separator(50)
        puts "Which State would you like to check? type number: "
        input = gets.chomp.to_i - 1
        if input.between?(0, STATES_WITH_RESORTS[region_num][region_key].size - 1)
            input
        else
            separator(55)
            puts "Invalid Choice. Please choose a Resort # between 1 - #{STATES_WITH_RESORTS[region_num][region_key].size}."
            separator(55)
            select_state(region_num, region_key)
        end
    end
    
    def separator(num)
        puts "-" * num
    end
    
    def display_xt_report
        report = resort.reports.first
        LocalSkiReport::Scraper.scrap_report_page(report)
        puts report.xt_report
    end
    
    def display_report
        puts @resort.reports.first.report
    end
    
    def exit_msg
        separator(60)
        puts "Check back later for the latest Ski reports."
        puts "Thanks for using Local Ski Reports gem!"
        separator(60)
    end

end
# Our CLI Controller
class LocalSkiReport::CLI
    attr_accessor :resort
    attr_reader :scraper, :output

    def initialize
      # LocalSkiReport::Scraper.scrap_resorts_page('united-states')
      @scraper = LocalSkiReport::Scraper.new
      @output  = LocalSkiReport::Output.new
    end

    def call
      @output.greeting
      menu
      exit_msg
    end

    def menu
      region_num = select_region
      user_region = get_key(region_num)
      separator(50)

      state_num = select_state(region_num, user_region)
      user_state = get_state(region_num, user_region, state_num)
      separator(50)

      select_resort(user_state)
      display_report

      input = nil
      while input != 'exit'
        puts "Type: 'more' for detailed report, 'new' for new search, 'exit' to Quit."
        input = gets.chomp.downcase

        case input
        when 'new'
          menu
          break
        when 'more'
          display_xt_report
        when 'exit'
          puts
          puts
          break
        else
          puts 'Invalid command entered.'
        end
      end
    end

    def get_key(num)
      STATES_WITH_RESORTS[num].keys[0]
    end

    def get_state(reg_num, user_reg, st_num)
      STATES_WITH_RESORTS[reg_num][user_reg][st_num] + ', USA'
    end

    def list_resorts(state)
      resorts = LocalSkiReport::Resort.find_by_location(state)
      # resorts = LocalSkiReport::Scraper.scrap_resorts_page(state)
      resorts.each.with_index(1) { |r, i| puts "#{i}. #{r.name}" }
      resorts
    end

    def select_region
      list_regions
      separator(50)
      puts 'Select a region to check? type number: '
      input = gets.chomp.to_i - 1
      if input.between?(0, STATES_WITH_RESORTS.size - 1)
        input
      else
        separator(55)
        puts "Invalid number. Please select a number between 1 - #{STATES_WITH_RESORTS.size}: "
        separator(55)
        select_region
      end
    end

    def select_resort(state)
      resorts_arr = list_resorts(state)
      separator(50)
      puts 'Select a Resort or Ski-Area for the latest Report: '
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
      puts 'Select a State to check? type number: '
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

    def display_xt_report
      report = resort.reports.first
      LocalSkiReport::Scraper.scrap_report_page(report)
      puts report.xt_report
    end

    def display_report
      puts @resort.reports.first.report
    end
end

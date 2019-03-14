# Our CLI Controller
class LocalSkiReport::CLI
    attr_accessor :resort
    attr_reader :scraper, :output

    def initialize
      # LocalSkiReport::Scraper.scrap_resorts_page('united-states')
      # @scraper = LocalSkiReport::Scraper.new
      @output  = LocalSkiReport::Output.new
    end

    def call
      output.greeting
      output.select_region
    end

    def menu
      output.list_regions
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
end

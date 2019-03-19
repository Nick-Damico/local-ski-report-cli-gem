# Our CLI Controller
class LocalSkiReport::CLI
    attr_accessor :resort
    attr_reader :scraper, :output, :scraper, :region, :region_num, :state_num

    def initialize
      # LocalSkiReport::Scraper.scrap_resorts_page('united-states')
      # @scraper = LocalSkiReport::Scraper.new
      @input = LocalSkiReport::Input.new
      @region = LocalSkiReport::Region.new
      @scraper = LocalSkiReport::Scraper.new
      @output  = LocalSkiReport::Output.new(
        input: @input,
        region: @region,
        scraper: @scraper)
    end

    def call
      output.greeting
      region_num = output.select_region
      state_num = output.select_state(region_num)
      state_name = region.get_state(region_num, state_num)      
      # scraper.scrape_usa_resorts
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

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

    def init
      scraper.scrape_usa_resorts
      self.call
    end

    def call
      output.greeting
      state_name = select_region_state
      resort_selection(state_name)
    end

    def select_region_state
      region_num = output.select_region
      state_num = output.select_state(region_num)
      # Returns state name ex. 'Tennessee'
      region.get_state(region_num, state_num)
    end

    def resort_selection(state_name)
      resorts = LocalSkiReport::Resort.find_by_location(state_name)
      output.select_resort(resorts)
    end

    def menu
      output.list_regions
    end
end

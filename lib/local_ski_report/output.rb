class LocalSkiReport::Output
  include Formattable
  attr_reader :artii, :input, :region, :scraper

  def initialize(args)
    @artii = Artii::Base.new
    @input = args[:input]
    @region = args[:region]
    @scraper = args[:scraper]
  end

  def self.loading(counter)
    print counter == 1 ? 'Loading' : '.'
  end

  def banner
    separator(80)
    puts artii.asciify('Local Ski Report')
    separator(80)
  end

  def display_report(report)
    puts report.report
  end

  def greeting
    banner
    puts "Let's Get Your Local Ski Report"
    puts ''
  end

  def invalid_selection(collection)
    separator(55)
    puts "Invalid selection. Please select a number between 1 - #{collection.length}: "
    separator(55)
  end

  def exit_msg
    separator(60)
    puts 'Check back later for the latest Ski reports.'
    puts 'Thanks for using Local Ski Report gem!'
    separator(60)
  end

  # Select methods may end up in ::Input classes responsibility
  def select_region
    msg = 'Select a region to check? type number'
    list_regions

    input.user_selection(msg, region.all_regions, self)
  end

  def select_state(region_num)
    msg = 'Select a State to check? type number: '
    list_states(region_num)

    input.user_selection(
      msg,
      region.all_states_in_region(region_num),
      self
    )
  end

  def select_resort(resorts)
    list_resorts(resorts)

    selection = input.user_selection(
      'Select a Resort',
      resorts,
      self
    )
    resorts[selection]
  end

  def list_regions
    regions = region.all_regions
    numbered_collection(regions).each { |region| puts region }
  end

  def list_resorts(resorts)
    numbered_collection(resorts.map(&:name)).each { |resort| puts resort }
  end

  def list_states(num)
    states = region.all_states_in_region(num)
    numbered_collection(states).each { |state| puts state }
  end

  def display_xt_report
    report = resort.reports.first
    @scraper.scrap_report_page(report)
    puts report.xt_report
  end

  def display_menu
    region_num = select_region
    state_num = select_state(region_num)

    state_name = region.get_state(region_num, state_num)

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
end

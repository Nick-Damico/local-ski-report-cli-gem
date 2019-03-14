class LocalSkiReport::Output
  include Formattable
  attr_reader :input

  def initialize
    @input = LocalSkiReport::Input.new
  end

  def greeting
    separator(40)
    puts 'Welcome to Local Ski Report gem'
    separator(40)
    puts "Let's Get Your Local Ski Report"
    puts ' '
  end

  def invalid_selection(collection)
    separator(55)
    puts "Invalid number. Please select a number between 1 - #{collection.length}: "
    separator(55)
  end

  def exit_msg
    separator(60)
    puts 'Check back later for the latest Ski reports.'
    puts 'Thanks for using Local Ski Report gem!'
    separator(60)
  end

  def list_regions
    regions = LocalSkiReport::Regions.all_regions
    numbered_collection(regions).each { |region| puts region }
  end

  def list_states(num)
    states = LocalSkiReport::Regions.all_states_in_region(num)
    numbered_collection(states).each { |state| puts state }
  end

  # Select methods may end up in ::Input classes responsibility
  def select_region
    msg = 'Select a region to check? type number: '
    list_regions
    input.user_selection(self, msg, LocalSkiReport::Regions.all_regions)
  end

  def select_state(region_num)
    msg = 'Select a State to check? type number: '
    list_states(region_num)
    input.user_selection(msg, LocalSkiReport::Regions.all_states_in_region(region_num), self)
  end

  def display_menu
    region_num = select_region
    state_num = select_state(region_num)

    state_name = LocalSkiReport::Regions.get_state(region_num, state_num)

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

class LocalSkiReport::Output
  include Formattable

  def greeting
    separator(40)
    puts 'Welcome to Local Ski Report gem'
    separator(40)
    puts "Let's Get Your Local Ski Report"
    puts ' '
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
    LocalSkiReport::CLI::STATES_WITH_RESORTS[num].each_value do |states|
      states.each.with_index(1) { |state, i| puts "#{i}. #{state}" }
    end
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

  def display_menu
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
end

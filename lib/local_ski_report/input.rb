class LocalSkiReport::Input
  include Formattable

  def correct_input_range(input, max_length)
    if input.between?(0, max_length)
      true
    else
      separator(55)
      puts "Invalid number. Please select a number between 1 - #{max_length}: "
      separator(55)
      false
    end
  end

  def number_selection
    gets.chomp.to_i - 1
  end

  def number_selection_with_msg(msg="Make a selection by type the number in console, press ENTER")
    puts "#{msg}: "
    gets.chomp.to_i - 1
  end

  def user_selection(msg, collection)
    user_selection = number_selection_with_msg(msg)
    until correct_input_range(user_selection, collection.length - 1)
      user_selection = number_selection
    end
    user_selection
  end
end

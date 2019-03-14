class LocalSkiReport::Input
  include Formattable

  def correct_input_range?(input, max_length)
    input.between?(0, max_length)
  end

  def number_selection
    gets.chomp.to_i - 1
  end

  def number_selection_with_msg(msg="Make a selection by type the number in console, press ENTER")
    puts "#{msg}: "
    gets.chomp.to_i - 1
  end

  def user_selection(msg, collection, output)
    user_selection = number_selection_with_msg(msg)
    until correct_input_range?(user_selection, collection.length - 1)
      output.invalid_selection(collection)
      user_selection = number_selection
    end

    user_selection
  end
end

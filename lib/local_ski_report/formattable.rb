module Formattable
  def downcase_to_sym(string)
    string.downcase.to_sym
  end

  def format_to_string(sym)
    sym.to_s.tr('_', '').upcase
  end

  def numbered_collection(collection)
    collection.collect.with_index(1) { |item, i| "#{i}. #{item}"}
  end

  def separator(num)
    puts '-' * num
  end

  def urlify(string)
    string.downcase.gsub(' ', '_')
  end
end

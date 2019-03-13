module Formattable
  def separator(num)
    puts '-' * num
  end

  def numbered_collection(collection)
    collection.collect.with_index(1) { |item, i| "#{i}. #{item}"}
  end

  def format_to_string(sym)
    sym.to_s.tr('_', '').upcase
  end

  def downcase_to_sym(string)
    string.downcase.to_sym
  end
end

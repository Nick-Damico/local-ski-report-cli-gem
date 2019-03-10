module Formattable
  def separator(num)
    puts '-' * num
  end

  def numbered_collection(collection)
    collection.collect.with_index(1) { |item, i| "#{i}. #{item}"}
  end
end

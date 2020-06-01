module Enumerable
  def my_each(array)
    array_copy = []
    array_size = array.length

    i = 0
    while i < array_size do
      array_copy << (yield array[i])
      i += 1
    end
    array_copy
  end

  def my_each_with_index(array)
    array_copy = []
    array_size = array.length

    i = 0
    while i < array_size do
      array_copy << (yield array[i], i)
      i += 1
    end
    array_copy
  end
end

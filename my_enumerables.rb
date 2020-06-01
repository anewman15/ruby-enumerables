module Enumerable
  def my_each(array)
    array_copy = []
    array_size = array.length

    i = 0
    while i < array_size do
      array_copy << (yield array[i])
      i += 1
    end
    array
  end

  def my_each_with_index(array)
    array_copy = []
    array_size = array.length

    i = 0
    while i < array_size do
      array_copy << (yield array[i], i)
      i += 1
    end
    array
  end

  def my_select(array)
    array_copy = []
    array_size = array.length

    i = 0
    while i < array_size do
      if (yield array[i]) == true
        array_copy << array[i]
      end
      i += 1
    end
    array_copy
  end
end

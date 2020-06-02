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

  def my_all?(array)
    array_size = array.length

    block_return = Hash.new
    i = 0
    while i < array_size do
      yield_value = yield array[i]
      if block_return[yield_value] 
        block_return[yield_value] += 1
      else
        block_return[yield_value] = 1
      end
      i += 1
    end

    if block_return[true] == array_size
      true
    else
      false
    end
  end

  def my_any?(array)
    array_size = array.length

    i = 0
    while i < array_size do
      if yield array[i]
        output = true
        break
      else
        output = false
      end
      i += 1
    end
    output
  end

  def my_none?(array)
    array_size = array.length

    block_return = Hash.new
    i = 0
    while i < array_size do
      yield_value = yield array[i]
      if block_return[yield_value] 
        block_return[yield_value] += 1
      else
        block_return[yield_value] = 1
      end
      i += 1
    end

    if block_return[true] == nil
      true
    else
      false
    end
  end

  def my_count(array)
    array_size = array.length

    block_return = Hash.new
    i = 0
    while i < array_size do
      yield_value = yield array[i]
      if block_return[yield_value] 
        block_return[yield_value] += 1
      else
        block_return[yield_value] = 1
      end
      i += 1
    end
    block_return[true].to_i
  end
end

module Enumerable
  def my_each
    array_copy = []
    array_size = self.length

    i = 0
    while i < array_size do
      array_copy << (yield self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    array_copy = []
    array_size = self.length

    i = 0
    while i < array_size do
      array_copy << (yield self[i], i)
      i += 1
    end
    self
  end

  def my_select
    array_selected = []
    array_size = self.length

    i = 0
    while i < array_size do
      if (yield self[i]) == true
        array_selected << self[i]
      end
      i += 1
    end
    array_selected
  end

  def my_all?
    array_size = self.length

    block_return = Hash.new
    i = 0
    while i < array_size do
      yield_value = yield self[i]
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

  def my_any?
    array_size = self.length

    i = 0
    while i < array_size do
      if yield self[i]
        output = true
        break
      else
        output = false
      end
      i += 1
    end
    output
  end

  def my_none?
    array_size = self.length

    block_return = Hash.new
    i = 0
    while i < array_size do
      yield_value = yield self[i]
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

  def my_count
    array_size = self.length

    block_return = Hash.new
    i = 0
    while i < array_size do
      yield_value = yield self[i]
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

module Enumerable
  def my_each
    modified_object = []
    object_size = self.length

    i = 0
    while i < object_size do
      modified_object << (yield self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    modified_object = []
    object_size = self.length

    i = 0
    while i < object_size do
      modified_object << (yield self[i], i)
      i += 1
    end
    self
  end

  def my_select
    modified_object = []
    object_size = self.length

    i = 0
    while i < object_size do
      if (yield self[i]) == true
        modified_object << self[i]
      end
      i += 1
    end
    modified_object
  end

  def my_all?
    object_size = self.length

    block_return = Hash.new
    i = 0
    while i < object_size do
      yield_value = yield self[i]
      if block_return[yield_value] 
        block_return[yield_value] += 1
      else
        block_return[yield_value] = 1
      end
      i += 1
    end

    if block_return[true] == object_size
      true
    else
      false
    end
  end

  def my_any?
    object_size = self.length

    i = 0
    while i < object_size do
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
    object_size = self.length

    block_return = Hash.new
    i = 0
    while i < object_size do
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
    object_size = self.length

    block_return = Hash.new
    i = 0
    while i < object_size do
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

  def my_map
    modified_object = []
    object_size = self.length

    i = 0
    while i < object_size do
      modified_object << (yield self[i])
      i += 1
    end
    modified_object
  end

  def my_inject(initial = nil)
    
    if initial
      memo = initial
      modified_object = my_map { |element| memo = yield memo, element }
      modified_object[-1]
    else
      memo = first
      modified_object = to_a[1..-1].my_map { |element| memo = yield memo, element }
      modified_object[-1]
    end
  end

  def multiply_els(array)
    array.my_inject { |memo, item| memo * item }
  end

  def my_map_proc(a_proc = nil)
    modified_object = []

    i = 0
    if a_proc
      while i < length
        modified_object << a_proc.call(self[i])
        i += 1
      end
    else
      while i < length do
        modified_object << (yield self[i])
        i += 1
      end
    end
    modified_object
  end
end

module Enumerable
  def my_each
    modified_object = []

    i = 0
    if block_given?
      while i < length do
        modified_object << (yield self[i])
        i += 1
      end
      self
    else
      to_enum
    end
  end

  def my_each_with_index
    modified_object = []

    i = 0
    if block_given?
      while i < length do
        modified_object << (yield self[i], i)
        i += 1
      end
      self
    else
      to_enum
    end
  end

  def my_select
    modified_object = []

    i = 0
    if block_given?
      while i < length do
        if (yield self[i]) == true
          modified_object << self[i]
        end
        i += 1
      end
      modified_object
    else
      to_enum
    end
  end

  def my_all?(pattern = nil)
    decision = true if length == 0 

    i = 0 
    if block_given?
      while i < length do
        unless yield self[i]
          decision = false
          break
        else
          decision = true
          i += 1
        end
      end
    elsif !block_given? && pattern
      while i < length do
        unless pattern === self[i]
          decision = false
          break
        else
          decision = true
          i += 1
        end
      end
    elsif !block_given? && !pattern
      while i < length do
        unless self[i] 
          decision = false
          break
        else
          decision = true
          i += 1
        end
      end
    else
      decision = true
    end
    decision
  end

  def my_any?(pattern = nil)
    decision = false if length == 0 

    i = 0 
    if block_given?
      while i < length do
        if yield self[i]
          decision = true
          break
        else
          decision = false
          i += 1
        end
      end
    elsif !block_given? && pattern
      while i < length do
        if pattern === self[i]
          decision = true
          break
        else
          decision = false
          i += 1
        end
      end
    elsif !block_given? && !pattern
      while i < length do
        if self[i] 
          decision = true
          break
        else
          decision = false
          i += 1
        end
      end
    else
      decision = true
    end
    decision
  end

  def my_none?(pattern = nil)
    decision = true if length == 0 

    i = 0 
    if block_given?
      while i < length do
        if yield self[i]
          decision = false
          break
        else
          decision = true
          i += 1
        end
      end
    elsif !block_given? && pattern
      while i < length do
        if pattern === self[i]
          decision = false
          break
        else
          decision = true
          i += 1
        end
      end
    elsif !block_given? && !pattern
      while i < length do
        if self[i] 
          decision = false
          break
        else
          decision = true
          i += 1
        end
      end
    else
      decision = true
    end
    decision
  end

  def my_count(value = nil)
    
    i = 0
    counter = 0
    if block_given?
      while i < length do
        if yield self[i]
          counter += 1
        else
          counter
        end
        i += 1
      end
      counter
    elsif !block_given? && value
      while i < length do
        if self[i] == value
          counter += 1
        else
          counter
        end
        i += 1
      end
      counter
    else
      length
    end
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
    end
    modified_object
  end

  def my_map_proc_block(a_proc = nil)
    modified_object = []

    i = 0
    if a_proc
      while i < length
        modified_object << a_proc.call(self[i])
        i += 1
      end
    elsif block_given?
      while i < length
        modified_object << (yield self[i])
        i += 1
      end
    end
    modified_object
  end
end

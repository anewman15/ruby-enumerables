module Enumerable
  def my_each
    modified_object = []

    i = 0
    if block_given?
      while i < length
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
      while i < length
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
      while i < length
        modified_object << self[i] if (yield self[i]) == true
        i += 1
      end
      modified_object
    else
      to_enum
    end
  end

  def my_all?(pattern = nil)
    decision = true if length.zero?

    i = 0
    if block_given?
      while i < length
        unless yield self[i]
          decision = false
          break
        else
          decision = true
          i += 1
        end
      end
    elsif !block_given? && pattern
      while i < length
        unless pattern === self[i]
          decision = false
          break
        else
          decision = true
          i += 1
        end
      end
    elsif !block_given? && !pattern
      while i < length
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
    decision = false if length.zero?

    i = 0
    if block_given?
      while i < length
        if yield self[i]
          decision = true
          break
        else
          decision = false
          i += 1
        end
      end
    elsif !block_given? && pattern
      while i < length
        if pattern === self[i]
          decision = true
          break
        else
          decision = false
          i += 1
        end
      end
    elsif !block_given? && !pattern
      while i < length
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
    decision = true if length.zero?

    i = 0
    if block_given?
      while i < length
        if yield self[i]
          decision = false
          break
        else
          decision = true
          i += 1
        end
      end
    elsif !block_given? && pattern
      while i < length
        if pattern === self[i]
          decision = false
          break
        else
          decision = true
          i += 1
        end
      end
    elsif !block_given? && !pattern
      while i < length
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
      while i < length
        if yield self[i]
          counter += 1
        else
          counter
        end
        i += 1
      end
      counter
    elsif !block_given? && value
      while i < length
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

    i = 0
    if block_given?
      while i < length
        modified_object << (yield self[i])
        i += 1
      end
      modified_object
    else
      to_enum
    end
  end

  def my_inject(initial = nil, method = nil)

    modified_object = []
    if block_given?
      if initial
        memo = initial
        modified_object = my_map { |element| memo = yield memo, element }
      else
        memo = first
        modified_object = to_a[1..-1].my_map { |element| memo = yield memo, element }
      end
    elsif !block_given?
      if initial && method
        memo = initial
        modified_object = my_map { |element| memo = memo.send(method, element) }
      elsif initial
        method = initial
        memo = first
        modified_object = to_a[1..-1].my_map { |element| memo = memo.send(method, element) }
      end
    end
    modified_object[-1]
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

module Enumerable
  def my_each
    arr = to_a
    i = 0
    if block_given?
      while i < arr.length
        yield arr[i]
        i += 1
      end
      self
    else
      to_enum
    end
  end

  def my_each_with_index
    arr = to_a
    i = 0
    if block_given?
      while i < arr.length
        yield arr[i], i
        i += 1
      end
      self
    else
      to_enum
    end
  end

  def my_select
    arr = to_a
    modified_object = []

    i = 0
    if block_given?
      while i < arr.length
        modified_object << arr[i] if (yield arr[i]) == true
        i += 1
      end
      modified_object
    else
      to_enum
    end
  end

  def my_all?(pattern = nil)
    arr = to_a
    true if arr.length.zero?
    selected_array = []

    i = 0
    if block_given?
      selected_array = my_select { |element| yield element }
    elsif !block_given? && pattern
      while i < arr.length
        selected_array << arr[i] if pattern === arr[i]
        i += 1
      end
    elsif !block_given? && !pattern
      while i < arr.length
        selected_array << arr[i] if arr[i]
        i += 1
      end
    end
    selected_array.length == arr.length
  end

  def my_any?(pattern = nil)
    false if length.zero?
    selected_array = []

    i = 0
    if block_given?
      selected_array = my_select { |element| yield element }
    elsif !block_given? && pattern
      while i < length
        selected_array << self[i] if pattern === self[i]
        i += 1
      end
    elsif !block_given? && !pattern
      while i < length
        selected_array << self[i] if self[i]
        i += 1
      end
    end
    selected_array.length.positive?
  end

  def my_none?(pattern = nil)
    true if length.zero?
    selected_array = []

    i = 0
    if block_given?
      selected_array = my_select { |element| yield element }
    elsif !block_given? && pattern
      while i < length
        selected_array << self[i] if pattern === self[i]
        i += 1
      end
    elsif !block_given? && !pattern
      while i < length
        selected_array << self[i] if self[i]
        i += 1
      end
    end
    selected_array.length.zero?
  end

  def my_count(*args)
    count_array = []

    i = 0
    if block_given?
      while i < length
        count_array << self[i] if yield self[i]
        i += 1
      end
    elsif !block_given? && !args.empty?
      while i < length
        count_array << self[i] if self[i] == args.first
        i += 1
      end
    else
      count_array = self
    end
    count_array.length
  end

  def my_map
    object = to_a
    modified_object = []

    i = 0
    if block_given?
      while i < to_a.length
        modified_object << (yield object[i])
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

def multiply_els(array)
  array.my_inject(:*)
end

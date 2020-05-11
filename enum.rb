# frozen_string_literal: true

#:nodoc:
module Enumerable
  # *********************************
  # Beginning of my_each method.
  # *********************************
  def my_each
    return to_enum :my_each unless block_given?

    0.upto(length - 1) do |index|
      yield self[index]
    end
  end

  # *********************************
  # End of my_each method.
  # *********************************

  # *********************************
  # Beginning of my_each_with_index method.
  # *********************************
  def my_each_with_index
    return to_enum :my_each_with_index unless block_given?

    0.upto(length - 1) do |index|
      yield self[index], index
    end
  end

  # *********************************
  # End of my_each_with_index method.
  # *********************************

  # *********************************
  # Beginning of my_select method.
  # *********************************
  def my_select
    arr = []
    return to_enum :my_select unless block_given?

    0.upto(length - 1) do |index|
      arr.push(self[index]) if yield(self[index])
    end
    arr
  end

  # *********************************
  # End of my_select method.
  # *********************************

  # *********************************
  # Beginning of my_all method.
  # *********************************
  def my_all
    temp = true
    return nil unless block_given?

    0.upto(length - 1) do |index|
      temp &&= yield(self[index])
    end
    temp
  end

  # *********************************
  # End of my_all method.
  # *********************************

  # *********************************
  # Beginning of my_any method.
  # *********************************
  def my_any
    temp = false
    0.upto(length - 1) do |index|
      temp ||= yield(self[index])
    end
    temp
  end

  # *********************************
  # End of my_any method.
  # *********************************

  # *********************************
  # Beginning of my_none? method.
  # *********************************
  def my_none?
    temp = true
    0.upto(length - 1) do |index|
      temp &&= !yield(self[index])
    end
    temp
  end

  # *********************************
  # End of my_none? method.
  # *********************************

  # *********************************
  # Beginning of my_count method.
  # *********************************
  def my_count(arg = 0)
    temp = 0
    return temp += (my_select { |x| x == arg }).length unless block_given?

    0.upto(length - 1) do |index|
      temp += 1 if yield(self[index])
    end
    temp
  end

  # *********************************
  # End of my_count method.
  # *********************************

  # *********************************
  # Beginning of my_map method.
  # *********************************
  def my_map
    mapped = []
    return to_enum :my_map unless block_given?

    0.upto(length - 1) do |index|
      mapped.push(yield self[index])
    end
    mapped
  end

  # *********************************
  # End of my_map method.
  # *********************************

  # *********************************
  # Beginning of my_map with proc method.
  # *********************************
  def my_map_proc(proc)
    mapped = []
    return to_enum :my_map_proc unless proc.is_a?(Proc)

    0.upto(length - 1) do |index|
      mapped.push(proc.call(self[index]))
    end
    mapped
  end

  # *********************************
  # End of my_map with proc method.
  # *********************************

  # *********************************
  # Beginning of my_map_pb method
  # *********************************
  # rubocop:disable Metrics/AbcSize
  def my_map_pb(proc = nil)
    mapped = []
    return to_enum :my_map_pb unless proc.is_a?(Proc) || block_given?

    0.upto(length - 1) do |index|
      mapped.push(proc.call(self[index])) if proc.is_a?(Proc)
      mapped.push(yield self[index]) if block_given? && !proc.is_a?(Proc)
    end
    mapped
  end

  # rubocop:enable Metrics/AbcSize
  # *********************************
  # End of my_map_pb method.
  # *********************************

  # *********************************
  # Beginning of my_inject method.
  # *********************************
  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/AbcSize, Metrics/MethodLength
  def my_inject(*args)
    input_arr = is_a?(Array) ? self : to_a
    input_arr.unshift(args[0]) if args[0].is_a?(Integer)
    accumulator = input_arr[0]
    @operator = args[1] if args[1].is_a?(Symbol) || args[1].is_a?(String)
    @operator = args[0] if args[0].is_a?(Symbol) || args[0].is_a?(String)

    1.upto(length - 1) do |index|
      if block_given?
        accumulator = yield(accumulator, input_arr[index])
      elsif !@operator.nil?
        accumulator = input_arr[index].send(@operator, accumulator)
      else
        return nil
      end
    end
    accumulator = yield(accumulator, input_arr[0]) if block_given?
    puts('Please enter arguments or a block') if accumulator == input_arr[0]
    accumulator
  end

  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity,  Metrics/AbcSize, Metrics/MethodLength
  # *********************************
  # End of my_inject method.
  # *********************************
end

# *********************************
# RUNNING TESTS BELOW
# *********************************

# *********************************
# Running my_each method test.
# *********************************
arr = []
[1, 2, 3, 4, 5].my_each { |num| arr.push(num * 2) }
print 'my_each: ', "\n", arr, "\n"
# ***************************************
# Running my_each_with_index method test.
# ***************************************

hash = {}
%w[cat dog wombat].my_each_with_index do |item, index|
  hash[item] = index
end
print 'my_each_with_index: ', "\n", hash, "\n"

# *********************************
# Running my_select method test.
# *********************************
print 'my_select: ', "\n", [1, 2, 3, 4, 5].my_select(&:even?), "\n"

# *********************************
# Running my_all method test.
# *********************************
print 'my_all:', "\n"
print([1, 2, 3, 4, 5].my_all { |num| num < 3 }, "\n")
print([1, 2, 3, 4, 5].my_all { |num| num < 10 }, "\n")

# *********************************
# Running my_any method test.
# *********************************
print 'my_any:', "\n"
print([1, 2, 3, 4, 5].my_any { |num| num < 1 }, "\n")
print([1, 2, 3, 4, 5].my_any { |num| num > 10 }, "\n")
print([].my_any { |num| num < 1 }, "\n")
print([1, 2, 3, 4, 5].my_any { |num| num < 10 }, "\n")

# *********************************
# Running my_none method test.
# *********************************
print 'my_none:', "\n"
print([1, 2, 3, 4, 5].my_none? { |num| num < 1 }, "\n")
print([1, 2, 3, 4, 5].my_none? { |num| num > 10 }, "\n")
print([].my_none? { |num| num < 1 }, "\n")
print([1, 2, 3, 4, 5].my_none? { |num| num < 10 }, "\n")

# *********************************
# Running my_count method test.
# *********************************
print 'my_count:', "\n"
print([1, 2, 3, 4, 5].my_count { |num| num < 3 }, "\n")
print([1, 2, 3, 4, 5].my_count { |num| num < 10 }, "\n")
print([2, 1, 2, 3, 4, 2, 5].my_count(2), "\n")

# *********************************
# Running my_map method test.
# *********************************
print 'my_map:', "\n"
print([1, 2, 3, 4, 5].my_map { |num| num < 3 }, "\n")
print([1, 2, 3, 4, 5].my_map { |num| num * 2 }, "\n")
print([1, 2, 3, 4, 5].my_map, "\n")

# *********************************
# Running my_inject method test.
# *********************************
print 'my_inject: The most difficult method I did :-)', "\n"
print([1, 2, 3, 4, 5].my_inject(2, :+), "\n")
print([1, 2, 3, 4, 5].my_inject { |accumulator, num| accumulator * num }, "\n")
print([1, 2, 3, 4, 5].my_inject, "\n")

# *********************************
# Beginning of multiply_els method.
# *********************************
def multiply_els(arr)
  arr.my_inject(1, :*)
end

# *********************************
# End of multiply_els method.
# *********************************

# *********************************
# Running multiply_els method test.
# *********************************
print 'multiply_els: multiply elements of an array', "\n"
print multiply_els([2, 4, 5]), "\n"

# *********************************
# Running my_map_proc method.
# *********************************
print 'my_map_proc: Accepts procs', "\n"

def procs(exp)
  proc { |x| x**exp }
end

test = procs(2)
print [2, 4, 5].my_map_proc(test), "\n"

# *********************************
# Running my_map_pb method.
# *********************************
print 'my_map_pb: Accepts both procs and blocs:', "\n"
print [2, 4, 5].my_map_pb(test), "\n"
print [2, 4, 5].my_map_pb(test) { |num| num < 3 }, "\n"
print([2, 4, 5].my_map_pb { |num| num < 3 }, "\n")

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
    puts("Please enter arguments or a block") if accumulator == input_arr[0]
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
print arr

# ***************************************
# Running my_each_with_index method test.
# ***************************************

hash = {}
%w[cat dog wombat].my_each_with_index do |item, index|
  hash[item] = index
end
print hash

# *********************************
# Running my_select method test.
# *********************************
print [1, 2, 3, 4, 5].my_select(&:even?)

# *********************************
# Running my_all method test.
# *********************************
print([1, 2, 3, 4, 5].my_all { |num| num < 3 })
print([1, 2, 3, 4, 5].my_all { |num| num < 10 })

# *********************************
# Running my_any method test.
# *********************************
print([1, 2, 3, 4, 5].my_any { |num| num < 1 })
print([1, 2, 3, 4, 5].my_any { |num| num > 10 })
print([].my_any { |num| num < 1 })
print([1, 2, 3, 4, 5].my_any { |num| num < 10 })

# *********************************
# Running my_none method test.
# *********************************
print([1, 2, 3, 4, 5].my_none? { |num| num < 1 })
print([1, 2, 3, 4, 5].my_none? { |num| num > 10 })
print([].my_none? { |num| num < 1 })
print([1, 2, 3, 4, 5].my_none? { |num| num < 10 })

# *********************************
# Running my_count method test.
# *********************************
print([1, 2, 3, 4, 5].my_count { |num| num < 3 })
print([1, 2, 3, 4, 5].my_count { |num| num < 10 })
print([2, 1, 2, 3, 4, 2, 5].my_count(2))

# *********************************
# Running my_map method test.
# *********************************
print([1, 2, 3, 4, 5].my_map { |num| num < 3 })
print([1, 2, 3, 4, 5].my_map { |num| num * 2 })
print([1, 2, 3, 4, 5].my_map)

# *********************************
# Running my_map method test.
# *********************************
print([1, 2, 3, 4, 5].my_inject(2, :+))
print([1, 2, 3, 4, 5].my_inject { |accumulator, num| accumulator * num })
print([1, 2, 3, 4, 5].my_inject)

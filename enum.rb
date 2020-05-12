# frozen_string_literal: true

#:nodoc:
# rubocop: disable Metrics/ModuleLength
module Enumerable
  # *********************************
  # Beginning of my_each method.
  # *********************************
  def my_each(nums = 0)
    checked = []
    num = nums.is_a?(Integer) && nums >= 1 ? nums : 0
    unless block_given?
      (return to_enum :my_each, (puts "=>", "No block was given", "\n"))
    end
    (return nil, puts("=>", "Array is empty", "\n")) if empty?

    0.upto(length - num) do |index|
      if num.is_a?(Integer) && num >= 1
        aux = []
        index.upto(index + num - 1) do |i|
          aux.push(yield self[i])
        end
        print aux, "\n" unless aux.empty?
      else
        checked.push(yield self[index]) unless self[index].nil?
      end
    end
    print checked unless checked.empty?
  end

  # rubocop:enable
  # *********************************
  # End of my_each method.
  # *********************************

  # *********************************
  # Beginning of my_each_with_index method.
  # *********************************
  def my_each_with_index(nums = 0)
    checked = {}
    num = nums.is_a?(Integer) && nums >= 1 ? nums : 0
    unless block_given?
      (return to_enum :my_each_with_index, (puts "=>", "No block was given", "\n"))
    end
    (return nil, puts("=>", "Array is empty", "\n")) if empty?

    0.upto(length - num) do |index|
      if num.is_a?(Integer) && num >= 1
        aux = {}
        index.upto(index + num - 1) do |i|
          aux[self[i]] = yield self[i], i
        end
        print aux, "\n" unless aux.empty?
      else
        checked[self[index]] = yield self[index], index unless self[index].nil?
      end
    end
    print checked unless checked.empty?
  end

  # *********************************
  # End of my_each_with_index method.
  # *********************************

  # *********************************
  # Beginning of my_select method.
  # *********************************
  def my_select
    arr = []
    unless block_given?
      return to_enum :my_select, print("No block was given.", "\n", "\n")
    end

    if !empty?
      0.upto(length - 1) do |index|
        arr.push(self[index]) if yield(self[index])
      end
    else
      print "=> ", "Array is empty.", "\n", "\n"
    end
    print("=> ", arr, "\n", "\n") unless arr.empty?
    arr
  end

  # *********************************
  # End of my_select method.
  # *********************************

  # *********************************
  # Beginning of my_all method.
  # *********************************
  def my_all?(arg = nil)
    temp = true
    0.upto(length - 1) do |index|
      temp &&= if block_given?
          yield(self[index])
        else
          (arg === self[index])
        end
    end
    temp
  end

  # *********************************
  # End of my_all? method.
  # *********************************

  # *********************************
  # Beginning of my_any? method.
  # *********************************
  def my_any?(arg = nil)
    temp = false
    0.upto(length - 1) do |index|
      temp ||= if block_given?
          yield(self[index])
        else
          (arg === self[index])
        end
    end
    temp
  end

  # *********************************
  # End of my_any? method.
  # *********************************

  # *********************************
  # Beginning of my_none? method.
  # *********************************
  def my_none?(pat = nil)
    temp = true
    0.upto(length - 1) do |index|
      temp &&= if block_given?
          !yield(self[index])
        else
          !(pat === self[index])
        end
    end
    temp
  end

  # *********************************
  # End of my_none? method.
  # *********************************

  # *************************(********
  # Beginning of my_count method.
  # *********************************
  NOTHING = Object.new

  def my_count(arg = NOTHING)
    if block_given?
      my_select { |index| yield index }.length
    else
      my_select { |index| index == arg || NOTHING === arg }.length
    end
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
  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
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

  # rubocop:enable, Metrics/AbcSize, Metrics/MethodLength
  # *********************************
  # End of my_inject method.
  # *********************************
end

# rubocop:enable Metrics/ModuleLength

# *********************************
# Beginning of multiply_els method.
# *********************************
def multiply_els(arr)
  arr.my_inject(1, :*)
end

# *********************************
# End of multiply_els method.
# *********************************

# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
#
# RUNNING TESTS BELOW
#
# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
# XXXXXXXXXXXXXXXXXXXXXXXXXXXX #
# XXXXXXXXXXXXXXXXXXXXXXXXXX #
# XXXXXXXXXXXXXXXXXXXXXX #
# XXXXXXXXXXXXXXXXXX #
# XXXXXXXXXXXXXX #
# XXXXXXXXXX #
# XXXXXX #
# XX #
#

# *********************************
# Running my_each method tests.
# *********************************
print "Running my_each method test:", "\n", "\n"
arr = []
print "arr = []", "\n", "\n"
print "arr.my_each(0) { |num| num * 2 }", "\n", "\n"
arr.my_each(0) { |num| num * 2 }
print "arr.my_each(3)", "\n", "\n"
arr.my_each(3)
print "[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].my_each (3) { |num| arr.push(num * 2) }", "\n", "\n"
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].my_each(3) { |num| num * 2 }
print "\n", "\n"
print "[1, 2, 3, 4, 5].my_each { |num| num * 2 }", "\n", "\n"
[1, 2, 3, 4, 5].my_each { |num| num * 2 }
print "\n", "\n"
# ***************************************
# Running my_each_with_index method tests.
# ***************************************
print "running my_each_with_index tests: ", "\n", "\n"
print "hash = {}
%w[cat dog wombat].my_each_with_index (2) do |item, index|
  hash[item] = index
end"
print "\n" "\n"
hash = {}
%w[cat dog wombat].my_each_with_index (2) do |item, index|
  hash[item] = index
end
print "\n" "\n"
print "%w[cat dog wombat].my_each_with_index do |item, index|
hash[item] = index
end"
print "\n" "\n"
%w[cat dog wombat].my_each_with_index do |item, index|
  hash[item] = index
end
print "\n", "\n"

# *********************************
# Running my_select method tests.
# *********************************
print "Running my_select:method tests ", "\n", "\n"

print "[1, 2, 3, 4, 5].my_select(&:even?)", "\n", "\n"

print [1, 2, 3, 4, 5].my_select(&:even?)
print "[1, 2, 3, 4, 5].my_select", "\n", "\n"
[1, 2, 3, 4, 5].my_select
print "[].my_select(&:even?)", "\n", "\n"
[].my_select(&:even?)

# *********************************
# Running my_all? method tests.
# *********************************
print "Running my_all? tests:", "\n", "\n"
print "[1, 2, 3, 4, 5].my_all? { |num| num < 3 }", "\n", "\n"
print([1, 2, 3, 4, 5].my_all? { |num| num < 3 }, "\n", "\n")
print "[1, 2, 3, 4, 5].my_all? { |num| num < 10 }", "\n", "\n"
print([1, 2, 3, 4, 5].my_all? { |num| num < 10 }, "\n", "\n")
print "[1, 2, 3, 4, 5].my_all?", "\n", "\n"
print([1, 2, 3, 4, 5].my_all?, "\n", "\n")
print "[1, 2, 3, 4, 5].my_all?(Numeric)", "\n", "\n"
print([1, 2, 3, 4, 5].my_all?(Numeric), "\n", "\n")
print "[].my_all?", "\n", "\n"
print([].my_all?, "\n", "\n")

# *********************************
# Running my_any? method test.
# *********************************
print "Running my_any? method test", "\n", "\n"
print("[1, 2, 3, 4, 5].my_any? { |num| num < 1 }", "\n", "\n")
print([1, 2, 3, 4, 5].my_any? { |num| num < 1 }, "\n", "\n")
print("[1, 2, 3, 4, 5].my_any? { |num| num > 10 }", "\n", "\n")
print([1, 2, 3, 4, 5].my_any? { |num| num > 10 }, "\n", "\n")
print("[].my_any? { |num| num < 1 }", "\n", "\n")
print([].my_any? { |num| num < 1 }, "\n", "\n")
print("[1, 2, 3, 4, 5].my_any? { |num| num < 10 }", "\n", "\n")
print([1, 2, 3, 4, 5].my_any? { |num| num < 10 }, "\n", "\n")
print("[].my_any?", "\n", "\n")
print([].my_any?, "\n", "\n")
print("[1, 2, 3, 4, 5].my_any?(Integer)", "\n", "\n")
print([1, 2, 3, 4, 5].my_any?(Integer), "\n", "\n")

# *********************************
# Running my_none? method tests.
# *********************************
print "Running my_none? method tests", "\n", "\n"
print("[1, 2, 3, 4, 5].my_none? { |num| num < 1 }", "\n", "\n")
print([1, 2, 3, 4, 5].my_none? { |num| num < 1 }, "\n", "\n")
print("[1, 2, 3, 4, 5].my_none? { |num| num > 10 }", "\n", "\n")
print([1, 2, 3, 4, 5].my_none? { |num| num > 10 }, "\n", "\n")
print("[].my_none? { |num| num < 1 }", "\n", "\n")
print([].my_none? { |num| num < 1 }, "\n", "\n")
print("[1, 2, 3, 4, 5].my_none? { |num| num < 10 }", "\n", "\n")
print([1, 2, 3, 4, 5].my_none? { |num| num < 10 }, "\n", "\n")
print("[].my_none?", "\n", "\n")
print([].my_none?, "\n", "\n")
print("[1, 2, 3, 4, 5].my_none?(Integer)", "\n", "\n")
print([1, 2, 3, 4, 5].my_none?(Integer), "\n", "\n")

# *********************************
# Running my_count method tests.
# *********************************
print "running my_count method tests:", "\n", "\n"
print("[1, 2, 3, 4, 5].my_count { |num| num < 3 }", "\n")
print([1, 2, 3, 4, 5].my_count { |num| num < 3 }, "\n", "\n")
print("[1, 2, 3, 4, 5].my_count { |num| num < 10 }", "\n", "\n")
print([1, 2, 3, 4, 5].my_count { |num| num < 10 }, "\n", "\n")
print("[2, 1, 2, 3, 4, 2, 5].my_count(2)", "\n", "\n")
print([2, 1, 2, 3, 4, 2, 5].my_count(2), "\n", "\n")
print("[2, 1, 2, 3, 4, 2, 5].my_count", "\n", "\n")
print([2, 1, 2, 3, 4, 2, 5].my_count, "\n", "\n")
print("[].my_count(2)", "\n", "\n")
print([].my_count(2), "\n", "\n")
print("[].my_count", "\n", "\n")
print([].my_count, "\n", "\n")
print("[].my_count { |num| num < 10 }", "\n", "\n")
print([].my_count { |num| num < 10 }, "\n", "\n")


# *********************************
# Running my_map method test.
# *********************************
print "my_map:", "\n"
print([1, 2, 3, 4, 5].my_map { |num| num < 3 }, "\n")
print([1, 2, 3, 4, 5].my_map { |num| num * 2 }, "\n")
print([1, 2, 3, 4, 5].my_map, "\n")

# *********************************
# Running my_inject method test.
# *********************************
print "my_inject: The most difficult method I did :-)", "\n"
print([1, 2, 3, 4, 5].my_inject(2, :+), "\n")
print([1, 2, 3, 4, 5].my_inject { |accumulator, num| accumulator * num }, "\n")
print([1, 2, 3, 4, 5].my_inject, "\n")

# *********************************
# Running multiply_els method test.
# *********************************
print "multiply_els: multiply elements of an array", "\n"
print multiply_els([2, 4, 5]), "\n"

# *********************************
# Running my_map_proc method.
# *********************************
print "my_map_proc: Accepts procs", "\n"

def procs(exp)
  proc { |x| x ** exp }
end

test = procs(2)
print [2, 4, 5].my_map_proc(test), "\n"

# *********************************
# Running my_map_pb method.
# *********************************
print "my_map_pb: Accepts both procs and blocs:", "\n"
print [2, 4, 5].my_map_pb(test), "\n"
print [2, 4, 5].my_map_pb(test) { |num| num < 3 }, "\n"
print([2, 4, 5].my_map_pb { |num| num < 3 }, "\n")

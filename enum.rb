# frozen_string_literal: true

#:nodoc:
# rubocop: disable Metrics/ModuleLength
module Enumerable
  # *********************************
  # Beginning of my_each method.
  # *********************************
  # rubocop: disable Metrics/AbcSize,Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Style/CaseEquality:
  def my_each(nums = NOTHING)
    return to_enum :my_each unless Integer === nums || block_given?

    (return nil, print('=>', 'Array is empty', "\n")) if empty?
    checked = []
    num = nums.is_a?(Integer) && nums >= 1 ? nums : 0
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

  # rubocop: enable Metrics/ModuleLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Style/CaseEquality:
  # *********************************
  # End of my_each method.
  # *********************************

  # *********************************
  # Beginning of my_each_with_index method.
  # *********************************
  # rubocop: disable Metrics/AbcSize,Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Style/CaseEquality:
  def my_each_with_index(nums = NOTHING)
    checked = {}
    num = nums.is_a?(Integer) && nums >= 1 ? nums : 0
    unless block_given? || Proc === nums
      return to_enum :my_each_with_index,
                     (print '=>', 'No block was given', "\n")
    end
    return nil, print('=>', 'Array is empty', "\n") if empty?

    0.upto(length - num) do |index|
      if num.is_a?(Integer) && num >= 1
        aux = {}
        index.upto(index + num - 1) do |i|
          aux[self[i]] = yield self[i], i
        end
        print aux, "\n" unless aux.empty?
      elsif Proc === nums
        unless self[index].nil?
          checked[self[index]] = nums.call(self[index], index)
        end
      else
        checked[self[index]] = yield self[index], index unless self[index].nil?
      end
    end
    print checked unless checked.empty?
  end

  # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Style/CaseEquality:

  # *********************************
  # End of my_each_with_index method.
  # *********************************

  # *********************************
  # Beginning of my_select method.
  # *********************************
  # rubocop:disable Metrics/MethodLength
  def my_select
    arr = []
    unless block_given?
      return to_enum :my_select, print('No block was given.', "\n", "\n")
    end

    if !empty?
      0.upto(length - 1) do |index|
        arr.push(self[index]) if yield(self[index])
      end
    else
      print '=> ', 'Array is empty.', "\n", "\n"
    end
    print('=> ', arr, "\n", "\n") unless arr.empty?
    arr
  end

  # rubocop: enable Metrics/MethodLength
  # *********************************
  # End of my_select method.
  # *********************************

  # *********************************
  # Beginning of my_all method.
  # *********************************
  # rubocop: disable Layout/EndAlignment, Style/CaseEquality, Metrics/MethodLength
  def my_all?(arg = NOTHING)
    temp = true
    0.upto(length - 1) do |index|
      temp &&= if block_given?
                 yield(self[index])
               elsif arg == NOTHING
                 true unless self[index].nil? || self[index] == false
               else
                 (arg === self[index])
        end
    end
    temp
  end

  # rubocop: enable Layout/EndAlignment, Style/CaseEquality, Metrics/MethodLength
  # *********************************
  # End of my_all? method.
  # *********************************

  # *********************************
  # Beginning of my_any? method.
  # *********************************
  # rubocop: disable Style/CaseEquality, Layout/EndAlignment, Metrics/MethodLength
  def my_any?(arg = NOTHING)
    temp = false
    0.upto(length - 1) do |index|
      temp ||= if block_given?
                 yield(self[index])
               elsif arg == NOTHING
                 true unless self[index].nil? || self[index] == false
               else
                 (arg === self[index])
        end
    end
    temp
  end

  # rubocop: enable Style/CaseEquality, Layout/EndAlignment, Metrics/MethodLength
  # *********************************
  # End of my_any? method.
  # *********************************

  # *********************************
  # Beginning of my_none? method.
  # *********************************
  # rubocop: disable Style/CaseEquality, Layout/EndAlignment, Metrics/MethodLength
  def my_none?(pat = NOTHING)
    temp = true
    0.upto(length - 1) do |index|
      temp &&= if block_given?
                 !yield(self[index])
               elsif pat == NOTHING
                 false unless self[index].nil? || self[index] == true
               else
                 !(pat === self[index])
        end
    end
    temp
  end

  # rubocop: enable Style/CaseEquality, Layout/EndAlignment, Metrics/MethodLength
  # *********************************
  # End of my_none? method.
  # *********************************

  # *************************(********
  # Beginning of my_count method.
  # *********************************
  # rubocop: disable Style/CaseEquality
  NOTHING = Object.new

  def my_count(arg = NOTHING)
    if block_given?
      my_select { |index| yield index }.length
    else
      my_select { |index| index == arg || NOTHING === arg }.length
    end
  end

  # rubocop: enable Style/CaseEquality

  # *********************************
  # End of my_count method.
  # *********************************

  # *********************************
  # Beginning of my_map method.
  # *********************************
  def my_map
    mapped = []
    return to_enum :my_map, print(' No block was given.') unless block_given?

    0.upto(length - 1) do |index|
      mapped.push(yield self[index])
    end
    mapped
  end

  # rubocop: enable, Metrics/PerceivedComplexity

  # *********************************
  # End of my_map method.
  # *********************************

  # *********************************
  # Beginning of my_map with proc method.
  # *********************************
  # rubocop: disable Layout/LineLength, Style/CaseEquality
  def my_map_proc(procs = NOTHING)
    mapped = []
    unless Proc === procs
      return to_enum :my_map_proc, print('Please enter a valid proc.', "\n", "\n")
    end

    0.upto(length - 1) do |index|
      mapped.push(procs.call(self[index]))
    end
    mapped
  end

  # rubocop: enable Layout/LineLength, Style/CaseEquality

  # *********************************
  # End of my_map with proc method.
  # *********************************

  # *********************************
  # Beginning of my_map_pb method
  # *********************************

  # rubocop: disable Metrics/AbcSize, Layout/LineLength, Style/CaseEquality
  def my_map_pb(procs = NOTHING)
    mapped = []
    unless Proc === procs || block_given?
      return to_enum :my_map_pb, print('Kindly enter a valid proc or block', "\n", "\n")
    end

    0.upto(length - 1) do |index|
      mapped.push(procs.call(self[index])) if Proc === procs
      mapped.push(yield self[index]) if block_given? && !Proc === procs
    end
    mapped
  end

  # rubocop: enable Metrics/AbcSize, Layout/LineLength, Style/CaseEquality
  # *********************************
  # End of my_map_pb method.
  # *********************************

  # *********************************
  # Beginning of my_inject method.
  # *********************************

  # rubocop: disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/MethodLength, Layout/LineLength
  def my_inject(*args)
    return accumulator = nil if empty?
    return accumulator = nil if args.empty? && !block_given?

    input_arr = is_a?(Array) ? self : to_a
    if (args.size == 1 && block_given?) || (args.size == 2 && !block_given?)
      input_arr.unshift(args[0])
    end
    accumulator = input_arr[0]
    @operator = args[1] if args[1].is_a?(Symbol) || args[1].is_a?(String)
    if (args[0].is_a?(Symbol) || args[0].is_a?(String)) && (args.size == 1 && !block_given?)
      @operator = args[0]
    end

    1.upto(length - 1) do |index|
      if block_given?
        accumulator = yield(accumulator, input_arr[index])
      elsif @operator.is_a?(Proc)
        accumulator = @operator.call(accumulator, self[index])
      elsif !@operator.nil?
        accumulator = input_arr[index].send(@operator, accumulator)
      end
    end
    print 'Array is empty. ' if accumulator.nil?
    accumulator
  end

  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/MethodLength, Metrics/PerceivedComplexity, Layout/LineLength
  # *********************************
  # End of my_inject method.
  # *********************************
end

# *********************************
# Beginning of multiply_els method.
# *********************************
# rubocop: disable Style/GuardClause, Style/CaseEquality
def multiply_els(arr = [])
  return arr.my_inject(1, :*) if Array === arr

  unless Array === arr
    [nil, print('Invalid argument, Insert an array of numbers', "\n", "\n")]
  end
end

# rubocop: enable Style/GuardClause, Style/CaseEquality

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
# rubocop: disable Layout/LineLength
print 'Running my_each method test:', "\n", "\n"
arr = []
print 'arr = []', "\n", "\n"
print 'arr.my_each(0) { |num| num * 2 }', "\n", "\n"
arr.my_each(0) { |num| num * 2 }
print 'arr.my_each(3)', "\n", "\n"
arr.my_each(3)
print '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].my_each (3) { |num| arr.push(num * 2) }', "\n", "\n"
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].my_each(3) { |num| num * 2 }
print "\n", "\n"
print '[1, 2, 3, 4, 5].my_each { |num| num * 2 }', "\n", "\n"
[1, 2, 3, 4, 5].my_each { |num| num * 2 }
print "\n", "\n"
print 'array = Array.new(100) { rand(0...9) }', "\n", "\n"
array = Array.new(100) { rand(0...9) }, "\n", "\n"
print '=> ', 'array.my_each == ', array.my_each, "\n", "\n"
# ***************************************
# Running my_each_with_index method tests.
# ***************************************
print 'running my_each_with_index tests: ', "\n", "\n"
print "hash = {}
%w[cat dog wombat].my_each_with_index (2) do |item, index|
  hash[item] = index
end"
print "\n", "\n"
hash = {}
%w[cat dog wombat].my_each_with_index(2) do |item, index|
  hash[item] = index
end
print "\n", "\n"
print "%w[cat dog wombat].my_each_with_index do |item, index|
hash[item] = index
end"
print "\n", "\n"
%w[cat dog wombat].my_each_with_index do |item, index|
  hash[item] = index
end
print "\n", "\n"

# *********************************
# Running my_select method tests.
# *********************************
print 'Running my_select:method tests ', "\n", "\n"

print '[1, 2, 3, 4, 5].my_select(&:even?)', "\n", "\n"

print [1, 2, 3, 4, 5].my_select(&:even?)
print '[1, 2, 3, 4, 5].my_select', "\n", "\n"
[1, 2, 3, 4, 5].my_select
print '[].my_select(&:even?)', "\n", "\n"
[].my_select(&:even?)

# *********************************
# Running my_all? method tests.
# *********************************
print 'Running my_all? tests:', "\n", "\n"
print '[1, 2, 3, 4, 5].my_all? { |num| num < 3 }', "\n", "\n"
print([1, 2, 3, 4, 5].my_all? { |num| num < 3 }, "\n", "\n")
print '[1, 2, 3, 4, 5].my_all? { |num| num < 10 }', "\n", "\n"
print([1, 2, 3, 4, 5].my_all? { |num| num < 10 }, "\n", "\n")
print '[1, 2, 3, 4, 5].my_all?', "\n", "\n"
print([1, 2, 3, 4, 5].my_all?, "\n", "\n")
print '[1, 2, 3, 4, 5].my_all?(Numeric)', "\n", "\n"
print([1, 2, 3, 4, 5].my_all?(Numeric), "\n", "\n")
print '[].my_all?', "\n", "\n"
print([].my_all?, "\n", "\n")
true_array = [1, true, 'hi', []], "\n", "\n"
print 'true_array.my_all? == true_array.all?', "\n", "\n"
print '=> ', true_array.my_all? == true_array.all?, "\n", "\n"

# *********************************
# Running my_any? method test.
# *********************************
print 'Running my_any? method test', "\n", "\n"
print('[1, 2, 3, 4, 5].my_any? { |num| num < 1 }', "\n", "\n")
print([1, 2, 3, 4, 5].my_any? { |num| num < 1 }, "\n", "\n")
print('[1, 2, 3, 4, 5].my_any? { |num| num > 10 }', "\n", "\n")
print([1, 2, 3, 4, 5].my_any? { |num| num > 10 }, "\n", "\n")
print('[].my_any? { |num| num < 1 }', "\n", "\n")
print([].my_any? { |num| num < 1 }, "\n", "\n")
print('[1, 2, 3, 4, 5].my_any? { |num| num < 10 }', "\n", "\n")
print([1, 2, 3, 4, 5].my_any? { |num| num < 10 }, "\n", "\n")
print('[].my_any?', "\n", "\n")
print([].my_any?, "\n", "\n")
print('[1, 2, 3, 4, 5].my_any?(Integer)', "\n", "\n")
print([1, 2, 3, 4, 5].my_any?(Integer), "\n", "\n")
print 'true_array = [nil, false, true, []]', "\n", "\n"
true_array = [nil, false, true, []], "\n", "\n"
print 'true_array.my_any? == true_array.any?', "\n", "\n"
print '=> ', true_array.my_any? == true_array.any?, "\n", "\n"

# *********************************
# Running my_none? method tests.
# *********************************
print 'Running my_none? method tests', "\n", "\n"
print('[1, 2, 3, 4, 5].my_none? { |num| num < 1 }', "\n", "\n")
print([1, 2, 3, 4, 5].my_none? { |num| num < 1 }, "\n", "\n")
print('[1, 2, 3, 4, 5].my_none? { |num| num > 10 }', "\n", "\n")
print([1, 2, 3, 4, 5].my_none? { |num| num > 10 }, "\n", "\n")
print('[].my_none? { |num| num < 1 }', "\n", "\n")
print([].my_none? { |num| num < 1 }, "\n", "\n")
print('[1, 2, 3, 4, 5].my_none? { |num| num < 10 }', "\n", "\n")
print([1, 2, 3, 4, 5].my_none? { |num| num < 10 }, "\n", "\n")
print('[].my_none?', "\n", "\n")
print([].my_none?, "\n", "\n")
print('[1, 2, 3, 4, 5].my_none?(Integer)', "\n", "\n")
print([1, 2, 3, 4, 5].my_none?(Integer), "\n", "\n")
print 'true_array = [nil, false, true, []]', "\n", "\n"
print 'false_array = [nil, false, nil, false]', "\n", "\n"
false_array = [nil, false, nil, false], "\n", "\n"
true_array = [nil, false, true, []], "\n", "\n"
print 'false_array.my_none? == true', "\n", "\n"
print '=> ', false_array.my_none? == true, "\n", "\n"
print 'true_array.my_none? == false', "\n", "\n"
print '=> ', true_array.my_none? == false, "\n", "\n"
print 'false_array.my_none? == false_array.none?', "\n", "\n"
print '=> ', false_array.my_none? == false_array.none?, "\n", "\n"
print 'true_array.my_none? == true_array.none?', "\n", "\n"
print '=> ', true_array.my_none? == true_array.none?, "\n", "\n"

# *********************************
# Running my_count method tests.
# *********************************
print 'running my_count method tests:', "\n", "\n"
print('[1, 2, 3, 4, 5].my_count { |num| num < 3 }', "\n")
print([1, 2, 3, 4, 5].my_count { |num| num < 3 }, "\n", "\n")
print('[1, 2, 3, 4, 5].my_count { |num| num < 10 }', "\n", "\n")
print([1, 2, 3, 4, 5].my_count { |num| num < 10 }, "\n", "\n")
print('[2, 1, 2, 3, 4, 2, 5].my_count(2)', "\n", "\n")
print([2, 1, 2, 3, 4, 2, 5].my_count(2), "\n", "\n")
print('[2, 1, 2, 3, 4, 2, 5].my_count', "\n", "\n")
print([2, 1, 2, 3, 4, 2, 5].my_count, "\n", "\n")
print('[].my_count(2)', "\n", "\n")
print([].my_count(2), "\n", "\n")
print('[].my_count', "\n", "\n")
print([].my_count, "\n", "\n")
print('[].my_count { |num| num < 10 }', "\n", "\n")
print([].my_count { |num| num < 10 }, "\n", "\n")

# *********************************
# Running my_map method tests.
# *********************************
print 'Running my_map method tests', "\n", "\n"
print('[1, 2, 3, 4, 5].my_map { |num| num < 3 }', "\n", "\n")
print([1, 2, 3, 4, 5].my_map { |num| num < 3 }, "\n", "\n")
print('[1, 2, 3, 4, 5].my_map { |num| num * 2 }', "\n", "\n")
print([1, 2, 3, 4, 5].my_map { |num| num * 2 }, "\n", "\n")
print('[1, 2, 3, 4, 5].my_map', "\n", "\n")
print([1, 2, 3, 4, 5].my_map, "\n", "\n")
print('[].my_map { |num| num * 2 }', "\n", "\n")
print([].my_map { |num| num * 2 }, "\n", "\n")
print 'array = Array.new(100){rand(0...9)}', "\n", "\n"
print 'block =  proc { |x| x ** 2 }', "\n", "\n"
print 'array.my_map(&block) == array.map(&block)', "\n", "\n"
array = Array.new(100) { rand(0...9) }
block = proc { |x| x**2 }
print '=>', array.my_map(&block) == array.map(&block), "\n", "\n"

# *********************************
# Running my_inject method test.
# *********************************
print 'Running my_inject method tests', "\n", "\n"
print('[1, 2, 3, 4, 5].my_inject(2, :+)', "\n", "\n")
print '=> ', [1, 2, 3, 4, 5].my_inject(2, :+), "\n", "\n"
print('[1, 2, 3, 4, 5].my_inject { |accumulator, num| accumulator * num }', "\n", "\n")
print '=> ', [1, 2, 3, 4, 5].my_inject { |accumulator, num| accumulator * num }, "\n", "\n"
print('[1, 2, 3, 4, 5].my_inject', "\n", "\n")
print '=> ', [1, 2, 3, 4, 5].my_inject, "\n", "\n"
print('[1, 2, 3, 4, 5].my_inject(2)', "\n", "\n")
print '=> ', [1, 2, 3, 4, 5].my_inject(2), "\n", "\n"
print('[].my_inject(2, :*)', "\n", "\n")
print '=> ', [].my_inject(2, :*), "\n", "\n"
print('[].my_inject { |accumulator, num| accumulator * num }', "\n", "\n")
print '=> ', [].my_inject { |accumulator, num| accumulator * num }, "\n", "\n"
print 'array = Array.new(100) { rand(0...9) }', "\n", "\n"
print 'array.my_inject(:+) == array.inject(:+)', "\n", "\n"
array = Array.new(100) { rand(0...9) }
print '=>', array.my_inject(:+) == array.inject(:+), "\n", "\n"
print 'operation = proc { |sum, n| sum + n }', "\n", "\n"
print 'search = proc { |memo, word| memo.length > word.length ? memo : word }', "\n", "\n"
print 'array = Array.new(100){rand(0...9)}', "\n", "\n"
print 'words = %w[dog door rod blade]', "\n", "\n"
operation = proc { |sum, n| sum + n }
search = proc { |memo, word| memo.length > word.length ? memo : word }
range = Array.new(100) { rand(0...9) }
words = %w[dog door rod blade], "\n", "\n"
print 'array.my_inject(&operation) == array.inject(&operation)', "\n", "\n"
print '=> ', array.my_inject(&operation) == array.inject(&operation), "\n", "\n" # should true
print 'actual = range.my_inject(4) { |prod, n| prod * n }', "\n", "\n"
actual = range.my_inject(4) { |prod, n| prod * n }, "\n", "\n"
print 'expected = range.inject(4) { |prod, n| prod * n }', "\n", "\n"
expected = range.inject(4) { |prod, n| prod * n }, "\n", "\n"
print 'actual == expected', "\n", "\n"
print '=> ', actual == expected, "\n", "\n"
print 'words.my_inject(&search) == words.inject(&search)', "\n", "\n"
print '=> ', words.my_inject(&search) == words.inject(&search), "\n", "\n"

# *********************************
# Running multiply_els method test.
# *********************************
print 'multiply_els: multiply elements of an array', "\n", "\n"
print 'multiply_els([2, 4, 5])', "\n", "\n"
print multiply_els([2, 4, 5]), "\n", "\n"
print 'multiply_els([])', "\n", "\n"
print multiply_els, "\n", "\n"
print 'multiply_els([])', "\n", "\n"
print multiply_els, "\n", "\n"
print 'multiply_els(3)', "\n", "\n"
print multiply_els(3), "\n", "\n"

# *********************************
# Running my_map_proc method.
# This method is an adaptation of my_map to accep procs.
# *********************************
print "Running my_map_proc method: Accepts procs.
This method is an adaptation of my_map to accep procs.", "\n", "\n"

print("def procs(power)
proc { |x| x ** power }
end

exp2 = procs(2)
print [2, 4, 5].my_map_proc(exp2)", "\n", "\n")

def procs(power)
  proc { |x| x**power }
end

exp2 = procs(2)
print [2, 4, 5].my_map_proc(exp2), "\n", "\n"
print '[2, 4, 5].my_map_proc()', "\n", "\n"
print [2, 4, 5].my_map_proc, "\n", "\n"
print '[].my_map_proc(exp2)', "\n", "\n"
print [].my_map_proc(exp2), "\n", "\n"

# *********************************
# Running my_map_pb method. This
# an adaptation of the my_map method
# to accept both procs and blocks.
# *********************************
print 'my_map_pb: Accepts both procs and blocs:', "\n", "\n"
print '[2, 4, 5].my_map_pb(exp2)', "\n", "\n"
print [2, 4, 5].my_map_pb(exp2), "\n", "\n"
print '[2, 4, 5].my_map_pb(exp2) { |num| num < 3 }', "\n", "\n"
print [2, 4, 5].my_map_pb(exp2) { |num| num < 3 }, "\n", "\n"
print('[2, 4, 5].my_map_pb { |num| num < 3 }', "\n", "\n")
print([2, 4, 5].my_map_pb { |num| num < 3 }, "\n", "\n")
print('[].my_map_pb { |num| num < 3 }', "\n", "\n")
print([].my_map_pb { |num| num < 3 }, "\n", "\n")
print('[2, 4, 5].my_map_pb', "\n", "\n")
print([2, 4, 5].my_map_pb, "\n", "\n")
# rubocop: enable Layout/LineLength

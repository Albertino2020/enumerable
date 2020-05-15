# frozen_string_literal: true

#:nodoc:
# rubocop: disable Metrics/ModuleLength
module Enumerable
  # rubocop: disable Metrics/AbcSize,Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Style/CaseEquality:
  def my_each
    return to_enum :my_each unless block_given?
    0.upto(length - 1) do |index|
      yield self[index]
    end
    self
  end

  def my_each_with_index(_block = NOTHING)
    unless block_given?
      return to_enum :my_each_with_index
    end
    0.upto(length - 1) do |index|
      yield self[index], index
    end
    self
  end

  # rubocop:disable Metrics/MethodLength
  def my_select
    arr = []
    unless block_given?
      return to_enum :my_select
    end
    0.upto(length - 1) do |index|
      arr.push(self[index]) if yield(self[index])
    end
    arr
  end

  # rubocop: enable Metrics/MethodLength

  # rubocop: disable Layout/EndAlignment, Style/CaseEquality, Metrics/MethodLength
  def my_all?(arg = NOTHING)
    temp = true
    0.upto(length - 1) do |index|
      temp &&= if block_given?
          yield(self[index])
        elsif arg == NOTHING
          !(self[index].nil? || self[index] == false)
        else
          (arg === self[index])
        end
    end
    temp
  end

  # rubocop: enable Layout/EndAlignment, Style/CaseEquality, Metrics/MethodLength

  # rubocop: disable Style/CaseEquality, Layout/EndAlignment, Metrics/MethodLength
  def my_any?(arg = NOTHING)
    temp = false
    0.upto(length - 1) do |index|
      temp ||= if block_given?
          yield(self[index])
        elsif arg == NOTHING
          !(self[index].nil? || self[index] == false)
        else
          (arg === self[index])
        end
    end
    temp
  end

  # rubocop: enable Style/CaseEquality, Layout/EndAlignment, Metrics/MethodLength

  # rubocop: disable Style/CaseEquality, Layout/EndAlignment, Metrics/MethodLength
  def my_none?(pat = NOTHING)
    temp = true
    0.upto(length - 1) do |index|
      temp &&= if block_given?
          !yield(self[index])
        elsif pat == NOTHING
          !self[index]
        else
          !(pat === self[index])
        end
    end
    temp
  end

  # rubocop: enable Style/CaseEquality, Layout/EndAlignment, Metrics/MethodLength
  *
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

  def my_map(proc = nil)
    return to_enum :my_map unless block_given?
    if proc
      return self.my_map_proc(proc)
    end
    self.my_map_pb(&Proc.new)
  end

  def my_map_proc(proc)
    mapped = []
    0.upto(length - 1) do |index|
      mapped.push(proc.call(self[index]))
    end
    mapped
  end

  def my_map_pb
    mapped = []
    0.upto(length - 1) do |index|
      mapped.push(yield self[index])
    end
    mapped
  end

  # rubocop: enable, Metrics/PerceivedComplexity

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
    print "Array is empty. " if accumulator.nil?
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
    [nil, print("Invalid argument, Insert an array of numbers", "\n", "\n")]
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
print [false, nil, false].my_none? #should return true
print [1, "demo", 2.2].my_none? #should return false
# *********************************
# Running my_each method tests.
# *********************************
# rubocop: disable Layout/LineLength
# print 'Running my_each method test:', "\n", "\n"
# arr = []
# print 'arr = []', "\n", "\n"
# print 'arr.my_each(0) { |num| num * 2 }', "\n", "\n"
# arr.my_each(0) { |num| num * 2 }
# print 'arr.my_each(3)', "\n", "\n"
# arr.my_each(3)
# print '[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].my_each (3) { |num| arr.push(num * 2) }', "\n", "\n"
# [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].my_each(3) { |num| num * 2 }
# print "\n", "\n"
# print '[1, 2, 3, 4, 5].my_each { |num| num * 2 }', "\n", "\n"
# [1, 2, 3, 4, 5].my_each { |num| num * 2 }
# print "\n", "\n"
# print 'array = Array.new(100) { rand(0...9) }', "\n", "\n"
# array = Array.new(100) { rand(0...9) }, "\n", "\n"
# print '=> ', 'array.my_each == ', array.my_each, "\n", "\n"
# # ***************************************
# # Running my_each_with_index method tests.
# # ***************************************
# print 'running my_each_with_index tests: ', "\n", "\n"
# print "hash = {}
# %w[cat dog wombat].my_each_with_index do |item, index|
#   my_hash[item] = index
# end"
# print "\n", "\n"
# my_hash = {}
# %w[cat dog wombat].my_each_with_index do |item, index|
#   my_hash[item] = index
# end
# print '=>', my_hash, "\n", "\n"
# print 'hash = {}', "\n", "\n"
# hash = {}
# print "%w[cat dog wombat].each_with_index do |item, index|
# hash[item] = index
# end"
# print "\n", "\n"
# %w[cat dog wombat].each_with_index do |item, index|
#   hash[item] = index
# end
# print '=>', hash, "\n", "\n"
# print 'my_hash == hash', "\n", "\n"
# print my_hash == hash, "\n", "\n"
# print 'my_each_output = array.my_each_with_index(&block), each_output = array.each_with_index(&block)', "\n", "\n"
# my_each_output = ''
# each_output = ''
# array = Array.new(15) { rand(0..9) }
# my_block = proc { |num, idx| my_each_output += "Num: #{num}, idx: #{idx}\n" }
# block = proc { |num, idx| each_output += "Num: #{num}, idx: #{idx}\n" }
# print "\n", "\n"
# my_each_output = array.my_each_with_index(&my_block), "\n", "\n"
# print 'my_each_output', "\n", "\n"
# print '=>', my_each_output, "\n", "\n"
# each_output = array.each_with_index(&block), "\n", "\n"
# print 'each_output', "\n", "\n"
# print '=>', each_output, "\n", "\n"
# print 'my_each_output == each_output', "\n", "\n"
# print '=>', my_each_output == each_output, "\n", "\n"

# # *********************************
# # Running my_select method tests.
# # *********************************
# print 'Running my_select:method tests ', "\n", "\n"

# print '[1, 2, 3, 4, 5].my_select(&:even?)', "\n", "\n"

# print [1, 2, 3, 4, 5].my_select(&:even?)
# print '[1, 2, 3, 4, 5].my_select', "\n", "\n"
# [1, 2, 3, 4, 5].my_select
# print '[].my_select(&:even?)', "\n", "\n"
# [].my_select(&:even?)

# # *********************************
# # Running my_all? method tests.
# # *********************************
# print 'Running my_all? tests:', "\n", "\n"
# print '[1, 2, 3, 4, 5].my_all? { |num| num < 3 }', "\n", "\n"
# print([1, 2, 3, 4, 5].my_all? { |num| num < 3 }, "\n", "\n")
# print '[1, 2, 3, 4, 5].my_all? { |num| num < 10 }', "\n", "\n"
# print([1, 2, 3, 4, 5].my_all? { |num| num < 10 }, "\n", "\n")
# print '[1, 2, 3, 4, 5].my_all?', "\n", "\n"
# print([1, 2, 3, 4, 5].my_all?, "\n", "\n")
# print '[1, 2, 3, 4, 5].my_all?(Numeric)', "\n", "\n"
# print([1, 2, 3, 4, 5].my_all?(Numeric), "\n", "\n")
# print '[].my_all?', "\n", "\n"
# print([].my_all?, "\n", "\n")
# true_array = [1, true, 'hi', []], "\n", "\n"
# print 'true_array.my_all? == true_array.all?', "\n", "\n"
# print '=> ', true_array.my_all? == true_array.all?, "\n", "\n"

# # *********************************
# # Running my_any? method test.
# # *********************************
# print 'Running my_any? method test', "\n", "\n"
# print('[1, 2, 3, 4, 5].my_any? { |num| num < 1 }', "\n", "\n")
# print([1, 2, 3, 4, 5].my_any? { |num| num < 1 }, "\n", "\n")
# print('[1, 2, 3, 4, 5].my_any? { |num| num > 10 }', "\n", "\n")
# print([1, 2, 3, 4, 5].my_any? { |num| num > 10 }, "\n", "\n")
# print('[].my_any? { |num| num < 1 }', "\n", "\n")
# print([].my_any? { |num| num < 1 }, "\n", "\n")
# print('[1, 2, 3, 4, 5].my_any? { |num| num < 10 }', "\n", "\n")
# print([1, 2, 3, 4, 5].my_any? { |num| num < 10 }, "\n", "\n")
# print('[].my_any?', "\n", "\n")
# print([].my_any?, "\n", "\n")
# print('[1, 2, 3, 4, 5].my_any?(Integer)', "\n", "\n")
# print([1, 2, 3, 4, 5].my_any?(Integer), "\n", "\n")
# print 'true_array = [nil, false, true, []]', "\n", "\n"
# true_array = [nil, false, true, []], "\n", "\n"
# print 'true_array.my_any? == true_array.any?', "\n", "\n"
# print '=> ', true_array.my_any? == true_array.any?, "\n", "\n"

# # *********************************
# # Running my_none? method tests.
# # *********************************
# print 'Running my_none? method tests', "\n", "\n"
# print('[1, 2, 3, 4, 5].my_none? { |num| num < 1 }', "\n", "\n")
# print([1, 2, 3, 4, 5].my_none? { |num| num < 1 }, "\n", "\n")
# print('[1, 2, 3, 4, 5].my_none? { |num| num > 10 }', "\n", "\n")
# print([1, 2, 3, 4, 5].my_none? { |num| num > 10 }, "\n", "\n")
# print('[].my_none? { |num| num < 1 }', "\n", "\n")
# print([].my_none? { |num| num < 1 }, "\n", "\n")
# print('[1, 2, 3, 4, 5].my_none? { |num| num < 10 }', "\n", "\n")
# print([1, 2, 3, 4, 5].my_none? { |num| num < 10 }, "\n", "\n")
# print('[].my_none?', "\n", "\n")
# print([].my_none?, "\n", "\n")
# print('[1, 2, 3, 4, 5].my_none?(Integer)', "\n", "\n")
# print([1, 2, 3, 4, 5].my_none?(Integer), "\n", "\n")
# print 'true_array = [nil, false, true, []]', "\n", "\n"
# print 'false_array = [nil, false, nil, false]', "\n", "\n"
# false_array = [nil, false, nil, false], "\n", "\n"
# true_array = [nil, false, true, []], "\n", "\n"
# print 'false_array.my_none? == true', "\n", "\n"
# print '=> ', false_array.my_none? == true, "\n", "\n"
# print 'true_array.my_none? == false', "\n", "\n"
# print '=> ', true_array.my_none? == false, "\n", "\n"
# print 'false_array.my_none? == false_array.none?', "\n", "\n"
# print '=> ', false_array.my_none? == false_array.none?, "\n", "\n"
# print 'true_array.my_none? == true_array.none?', "\n", "\n"
# print '=> ', true_array.my_none? == true_array.none?, "\n", "\n"

# # *********************************
# # Running my_count method tests.
# # *********************************
# print 'running my_count method tests:', "\n", "\n"
# print('[1, 2, 3, 4, 5].my_count { |num| num < 3 }', "\n")
# print([1, 2, 3, 4, 5].my_count { |num| num < 3 }, "\n", "\n")
# print('[1, 2, 3, 4, 5].my_count { |num| num < 10 }', "\n", "\n")
# print([1, 2, 3, 4, 5].my_count { |num| num < 10 }, "\n", "\n")
# print('[2, 1, 2, 3, 4, 2, 5].my_count(2)', "\n", "\n")
# print([2, 1, 2, 3, 4, 2, 5].my_count(2), "\n", "\n")
# print('[2, 1, 2, 3, 4, 2, 5].my_count', "\n", "\n")
# print([2, 1, 2, 3, 4, 2, 5].my_count, "\n", "\n")
# print('[].my_count(2)', "\n", "\n")
# print([].my_count(2), "\n", "\n")
# print('[].my_count', "\n", "\n")
# print([].my_count, "\n", "\n")
# print('[].my_count { |num| num < 10 }', "\n", "\n")
# print([].my_count { |num| num < 10 }, "\n", "\n")

# # *********************************
# # Running my_map method tests.
# # *********************************
# print 'Running my_map method tests', "\n", "\n"
# print('[1, 2, 3, 4, 5].my_map { |num| num < 3 }', "\n", "\n")
# print([1, 2, 3, 4, 5].my_map { |num| num < 3 }, "\n", "\n")
# print('[1, 2, 3, 4, 5].my_map { |num| num * 2 }', "\n", "\n")
# print([1, 2, 3, 4, 5].my_map { |num| num * 2 }, "\n", "\n")
# print('[1, 2, 3, 4, 5].my_map', "\n", "\n")
# print([1, 2, 3, 4, 5].my_map, "\n", "\n")
# print('[].my_map { |num| num * 2 }', "\n", "\n")
# print([].my_map { |num| num * 2 }, "\n", "\n")
# print 'array = Array.new(100){rand(0...9)}', "\n", "\n"
# print 'block =  proc { |x| x ** 2 }', "\n", "\n"
# print 'array.my_map(&block) == array.map(&block)', "\n", "\n"
# array = Array.new(100) { rand(0...9) }
# block = proc { |x| x**2 }
# print '=>', array.my_map(&block) == array.map(&block), "\n", "\n"

# # *********************************
# # Running my_inject method test.
# # *********************************
# print 'Running my_inject method tests', "\n", "\n"
# print('[1, 2, 3, 4, 5].my_inject(2, :+)', "\n", "\n")
# print '=> ', [1, 2, 3, 4, 5].my_inject(2, :+), "\n", "\n"
# print('[1, 2, 3, 4, 5].my_inject { |accumulator, num| accumulator * num }', "\n", "\n")
# print '=> ', [1, 2, 3, 4, 5].my_inject { |accumulator, num| accumulator * num }, "\n", "\n"
# print('[1, 2, 3, 4, 5].my_inject', "\n", "\n")
# print '=> ', [1, 2, 3, 4, 5].my_inject, "\n", "\n"
# print('[1, 2, 3, 4, 5].my_inject(2)', "\n", "\n")
# print '=> ', [1, 2, 3, 4, 5].my_inject(2), "\n", "\n"
# print('[].my_inject(2, :*)', "\n", "\n")
# print '=> ', [].my_inject(2, :*), "\n", "\n"
# print('[].my_inject { |accumulator, num| accumulator * num }', "\n", "\n")
# print '=> ', [].my_inject { |accumulator, num| accumulator * num }, "\n", "\n"
# print 'array = Array.new(100) { rand(0...9) }', "\n", "\n"
# print 'array.my_inject(:+) == array.inject(:+)', "\n", "\n"
# array = Array.new(100) { rand(0...9) }
# print '=>', array.my_inject(:+) == array.inject(:+), "\n", "\n"
# print 'operation = proc { |sum, n| sum + n }', "\n", "\n"
# print 'search = proc { |memo, word| memo.length > word.length ? memo : word }', "\n", "\n"
# print 'array = Array.new(100){rand(0...9)}', "\n", "\n"
# print 'words = %w[dog door rod blade]', "\n", "\n"
# operation = proc { |sum, n| sum + n }
# search = proc { |memo, word| memo.length > word.length ? memo : word }
# range = Array.new(100) { rand(0...9) }
# words = %w[dog door rod blade], "\n", "\n"
# print 'array.my_inject(&operation) == array.inject(&operation)', "\n", "\n"
# print '=> ', array.my_inject(&operation) == array.inject(&operation), "\n", "\n" # should true
# print 'actual = range.my_inject(4) { |prod, n| prod * n }', "\n", "\n"
# actual = range.my_inject(4) { |prod, n| prod * n }, "\n", "\n"
# print 'expected = range.inject(4) { |prod, n| prod * n }', "\n", "\n"
# expected = range.inject(4) { |prod, n| prod * n }, "\n", "\n"
# print 'actual == expected', "\n", "\n"
# print '=> ', actual == expected, "\n", "\n"
# print 'words.my_inject(&search) == words.inject(&search)', "\n", "\n"
# print '=> ', words.my_inject(&search) == words.inject(&search), "\n", "\n"

# # *********************************
# # Running multiply_els method test.
# # *********************************
# print 'multiply_els: multiply elements of an array', "\n", "\n"
# print 'multiply_els([2, 4, 5])', "\n", "\n"
# print multiply_els([2, 4, 5]), "\n", "\n"
# print 'multiply_els([])', "\n", "\n"
# print multiply_els, "\n", "\n"
# print 'multiply_els([])', "\n", "\n"
# print multiply_els, "\n", "\n"
# print 'multiply_els(3)', "\n", "\n"
# print multiply_els(3), "\n", "\n"

# # *********************************
# # Running my_map_proc method.
# # This method is an adaptation of my_map to accep procs.
# # *********************************
# print "Running my_map_proc method: Accepts procs.
# This method is an adaptation of my_map to accep procs.", "\n", "\n"

# print("def procs(power)
# proc { |x| x ** power }
# end

# exp2 = procs(2)
# print [2, 4, 5].my_map_proc(exp2)", "\n", "\n")

# def procs(power)
#   proc { |x| x**power }
# end

# exp2 = procs(2)
# print [2, 4, 5].my_map_proc(exp2), "\n", "\n"
# print '[2, 4, 5].my_map_proc()', "\n", "\n"
# print [2, 4, 5].my_map_proc, "\n", "\n"
# print '[].my_map_proc(exp2)', "\n", "\n"
# print [].my_map_proc(exp2), "\n", "\n"

# # *********************************
# # Running my_map_pb method. This
# # an adaptation of the my_map method
# # to accept both procs and blocks.
# # *********************************
# print 'my_map_pb: Accepts both procs and blocs:', "\n", "\n"
# print '[2, 4, 5].my_map_pb(exp2)', "\n", "\n"
# print [2, 4, 5].my_map_pb(exp2), "\n", "\n"
# print '[2, 4, 5].my_map_pb(exp2) { |num| num < 3 }', "\n", "\n"
# print [2, 4, 5].my_map_pb(exp2) { |num| num < 3 }, "\n", "\n"
# print('[2, 4, 5].my_map_pb { |num| num < 3 }', "\n", "\n")
# print([2, 4, 5].my_map_pb { |num| num < 3 }, "\n", "\n")
# print('[].my_map_pb { |num| num < 3 }', "\n", "\n")
# print([].my_map_pb { |num| num < 3 }, "\n", "\n")
# print('[2, 4, 5].my_map_pb', "\n", "\n")
# print([2, 4, 5].my_map_pb, "\n", "\n")
# # rubocop: enable Layout/LineLength

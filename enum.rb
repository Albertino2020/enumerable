# frozen_string_literal: true

module Enumerable
  def my_each
    0.upto(length - 1) do |index|
      yield self[index]
    end
  end

  def my_each_with_index
    0.upto(length - 1) do |index|
      yield self[index], index
    end
  end
end

print([1, 2, 3, 4, 5].my_each { |num| puts num * 2 })
hash = {}
%w[cat dog wombat].my_each_with_index do |item, index|
  hash[item] = index
end
print hash

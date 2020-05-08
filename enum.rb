# frozen_string_literal: true

module Enumerable
  def my_each
    0.upto(self.length - 1) do |index|
      yield self[index]
    end
  end
end

print [1, 2, 3, 4, 5].my_each { |num| puts num * 2 }

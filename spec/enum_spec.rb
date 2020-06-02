# frozen_string_literal: true

require "./enum.rb"

describe Enumerable do
  let(:arr) { [1, 2, 3, 4, 5, 6] }
  let(:arr2) { [1, nil, 3, 4, 5, 6] }
  let(:arr3) { [1, 2, 3, 4, false, 6] }
  let(:arr4) { [false, false, false] }

  describe "#my_each" do
    context "If a block is not given" do
      it "returns Enumerator" do
        expect(arr.my_each).to be_kind_of(Enumerator)
      end
    end
    context "if a block is given" do
      it "returns self" do
        expect(arr.my_each { |x| x ** 2 }).to eql(arr)
      end
    end
  end

  describe "#my_each_with_index" do
    context "If a block is not given" do
      it "returns Enumerator" do
        expect(arr.my_each_with_index).to be_kind_of(Enumerator)
      end
    end
    context "if a block is given" do
      it "returns self" do
        expect(arr.my_each_with_index { |x, index| [x ** 2, index] }).to eql(arr)
      end
    end
  end

  describe "#my_select" do
    context "If a block is not given" do
      it "returns Enumerator" do
        expect(arr.my_select).to be_kind_of(Enumerator)
      end
    end
    context "if a block is given" do
      it "returns even elements" do
        expect(arr.my_select(&:even?)).to eql([2, 4, 6])
      end
      it "returns odd elements" do
        expect(arr.my_select(&:odd?)).to eql([1, 3, 5])
      end
      it "returns the array of elements whose square are less than 10" do
        expect(arr.my_select { |x| x ** 2 < 10 }).to eql([1, 2, 3])
      end
    end
  end

  describe "#my_all?" do
    context "if a block is given" do
      it "returns false if all elements are divisible by 2" do
        expect(arr.my_all?(&:even?)).to eql(false)
      end
      it "returns false if all elements are not divisible by 2" do
        expect(arr.my_all?(&:odd?)).to eql(false)
      end
      it "returns true if all elements squared are less or equal to 36" do
        expect(arr.my_all? { |x| x ** 2 <= 36 }).to eql(true)
      end
      it "returns false if the array is empty" do
        expect([].my_all?(&:odd?)).to eql(true)
      end
    end

    context "if a block is not given" do
      it "returns true if no element is nil or false" do
        expect(arr.my_all?).to eql(true)
      end
      it "returns false if an element is nil or false" do
        expect(arr2.my_all?).to eql(false)
      end
      it "returns false if an element is nil or false" do
        expect(arr3.my_all?).to eql(false)
      end
      it "returns true" do
        expect([].my_all?).to eql(true)
      end
    end
  end

  describe "#my_any?" do
    context "if a block is given" do
      it "returns true if there at least one element divisible by 2" do
        expect(arr.my_any?(&:even?)).to eql(true)
      end
      it "returns true if at least one element is not divisible by 2" do
        expect(arr.my_any?(&:odd?)).to eql(true)
      end
      it "returns false if no element squared is greater than 36" do
        expect(arr.my_any? { |x| x ** 2 > 36 }).to eql(false)
      end
      it "returns any if the array is empty" do
        expect([].my_any?(&:odd?)).to eql(false)
      end
    end

    context "if a block is not given" do
      it "returns true if no element is nil or false" do
        expect(arr.my_any?).to eql(true)
      end
      it "returns true if an element is nil or false" do
        expect(arr2.my_any?).to eql(true)
      end
      it "returns true if an element is nil or false" do
        expect(arr3.my_any?).to eql(true)
      end
      it "returns false" do
        expect([].my_any?).to eql(false)
      end
    end
  end

  describe "#none?" do
    context "if a block is given" do
      it "returns false if there are even elements" do
        expect(arr.none?(&:even?)).to eql(false)
      end
      it "returns true if none of the elements is greater than 10" do
        expect(arr.none? { |x| x > 10 }).to eql(true)
      end
      it "returns true if an element squared is greater than 36" do
        expect(arr.none? { |x| x ** 2 > 36 }).to eql(true)
      end
      it "returns true if the array is empty" do
        expect([].none?(&:odd?)).to eql(true)
      end
    end

    context "if a block is not given" do
      it "returns false if no element is nil or false" do
        expect(arr.none?).to eql(false)
      end
      it "returns false if array has true elements" do
        expect(arr2.none?).to eql(false)
      end
      it "returns true if an element is nil or false" do
        expect(arr4.none?).to eql(true)
      end
      it "returns true when array is empty" do
        expect([].none?).to eql(true)
      end
    end
  end

  describe "#count" do
    context "if a block is given" do
      it "returns the number of even elements" do
        expect(arr.count(&:even?)).to eql(3)
      end
      it "returns the number of elements that are greater than 10" do
        expect(arr.my_count { |x| x > 10 }).to eql(0)
      end
      it "returns the number of elements that squared are greater than 36" do
        expect(arr.my_count { |x| x ** 2 > 36 }).to eql(0)
      end
      it "returns the number of odd elements" do
        expect([].my_count(&:odd?)).to eql(0)
      end
    end

    context "if a block is not given and not argument" do
      it "returns the number of elements of the array" do
        expect(arr.my_count).to eql(6)
      end
      it "returns 0 if the array is empty" do
        expect([].my_count).to eql(0)
      end
    end

    context "if a block is not given but an argument is given" do
      it "returns the number of the elements in the array that are equal to the argument" do
        expect(arr.my_count(2)).to eql(1)
      end
      it "returns the number of elements that are nil" do
        expect(arr2.my_count(nil)).to eql(1)
      end
      it "returns the number of elements that are false" do
        expect(arr4.my_count(false)).to eql(3)
      end
      it "returns the number of elments equal to the boolean true" do
        expect([].my_count(true)).to eql(0)
      end
    end
  end

  describe "#my_map" do
    context "If a block is not given" do
      it "returns Enumerator" do
        expect(arr.my_map).to be_kind_of(Enumerator)
      end
    end
    context "if a block is given" do
      it "returns a new array with elements multiplied by 2" do
        expect(arr.my_map { |x| x * 2 }).to eql([2, 4, 6, 8, 10, 12])
      end
      it "returns a new array with true is element is less that 2, otherwise false" do
        expect(arr.my_map { |x| x < 2 }).to eql([true, false, false, false, false, false])
      end
    end
    context "if no block given but a proc is given" do
      let(:my_proc) { proc { |x| x * 2 } }
      it "returns a new array with elements multiplied by 2" do
        expect(arr.my_map(&my_proc)).to eql([2, 4, 6, 8, 10, 12])
      end
    end
  end

  describe "#my_inject" do
    context "If a block is not given" do
      it "returns nil if array is empty" do
        expect([].my_inject).to be nil
      end
      it "returns nil if array is empty" do
        expect([].my_inject(:+)).to be nil
      end
      it "returns nil if array is empty" do
        expect([].my_inject(2,:+)).to eql(2)
      end 
    end
    context "if a block is given but no argument is given" do
      it "returns the product of all elements of the array." do
        expect([2, 3, 4, 2].my_inject { |acc, x| acc * x }).to eql(48)
      end
      it "returns the product of all elements of the array." do
        expect([].my_inject { |acc, x| acc * x }).to be nil
      end
    end
    context "if a block given but with an argument" do
      it "returns the product of all elments of the array multiplied by the argument" do
        expect([2, 3, 4, 2].my_inject(2) { |acc, x| acc * x }).to eql(96)
      end
      it "returns the product of all elments of the array multiplied by the argument" do
        expect([].my_inject(2) { |acc, x| acc * x }).to eql(2)
      end
    end
    context "if no block is given but an operator or proc is given" do
      it "returns the product of all elments of the array multiplied by the argument" do
        expect([2, 3, 4, 2].my_inject(:+)).to eql(11)
      end
      it "returns the product of all elments of the array multiplied by the argument" do
        expect([2, 3, 4, 2].my_inject(5, :+)).to eql(16)
      end
    end
  end
end

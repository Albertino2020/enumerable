require "./enum.rb"

describe Enumerable do 
    let(:arr) {[1, 2, 3, 4, 5, 6]}
  describe "#my_each" do
   
    context "If a block is not given" do
      it "returns enumerable" do
        expect(arr.my_each).to be_kind_of(Enumerator)
      end
    end
    context "if a block is given" do
        it "returns self" do
            expect(arr.my_each {|x| x ** 2}).to eql(arr)
        end
    end
  end
end

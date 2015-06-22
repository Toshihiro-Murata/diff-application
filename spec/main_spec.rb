require 'spec_helper'

describe Main do

  it "args_to_array returns Array object without nil values" do
    obj = Main.new.args_to_array( '[1,2, 4 , 5, nil,]' )
    expect( obj.instance_of? Array ).to eq true
    expect( obj.length ).to eq 4
    expect( obj[0] ).to eq 1
    expect( obj[3] ).to eq 5
  end

  it "get exception if args_to_array recieves an invalid value" do
    ['','nil','false'].each do |val|
      expect do
        obj = Main.new.args_to_array(val)
      end.to raise_error( RuntimeError, "Invalid value for args_to_array(): #{val}!" )
    end
    
    ['[','*'].each do |val|
      expect do
        obj = Main.new.args_to_array( val )
      end.to raise_error( SyntaxError, "Invalid value for args_to_array(): #{val}!" )
    end
  end

  it "get_unmatch return 10000" do
    target_array = (1..9999).to_a.shuffle
    expect( Main.new.get_unmatch(target_array) ).to eq 10000
  end

  it "get_unmatch return 1" do
      target_array = Array.new()
      (1..10000).to_a.shuffle.each do |i|
        target_array.push(i) unless i == 1
      end
      expect( Main.new.get_unmatch(target_array) ).to eq 1
  end

  it "get_unmatch return an unmatched value" do
      (1..100).to_a.each do |i|
        target_array = Array.new()
        (1..10000).to_a.shuffle.each do |j|
          target_array.push(j) unless i == j
        end
        expect( Main.new.get_unmatch(target_array) ).to eq i
      end
  end

  it "get exception if target_array length is not 9999 but 9998" do
    expect do
      target_array = (1..9998).to_a.shuffle
      Main.new.get_unmatch(target_array)
    end.to raise_error( RuntimeError, "Invalid parameter length!" )
  end

  it "get exception if target_array length is not 9999 but 10001" do
    expect do
      target_array = (1..10001).to_a.shuffle
      Main.new.get_unmatch(target_array)
    end.to raise_error( RuntimeError, "Invalid parameter length!" )
  end

end

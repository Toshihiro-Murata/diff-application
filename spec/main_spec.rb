require 'spec_helper'

describe Main do
  it "get_unmatch return 10000" do
    target_array = (1..9999).to_a.shuffle
    expect(Main.new.get_unmatch(target_array)).to eq 10000
  end

  it "get_unmatch return 1" do
      target_array = Array.new()
      (1..10000).to_a.shuffle.each do |i|
        target_array.push(i) unless i == 1
      end
      expect(Main.new.get_unmatch(target_array)).to eq 1
  end

  it "get_unmatch return 10000" do
    target_array = Array.new()
      (1..10000).to_a.shuffle.each do |i|
        target_array.push(i) unless i == 10000
      end
      expect(Main.new.get_unmatch(target_array)).to eq 10000
  end

  it "get exception if target_array length is not 9999 but 9998" do
    expect do
      target_array = (1..9998).to_a.shuffle
      Main.new.get_unmatch(target_array)
    end.to raise_error(RuntimeError, "Invalid parameter length!")
  end

  it "get exception if target_array length is not 9999 but 10001" do
    expect do
      target_array = (1..10001).to_a.shuffle
      Main.new.get_unmatch(target_array)
    end.to raise_error(RuntimeError, "Invalid parameter length!")
  end
end

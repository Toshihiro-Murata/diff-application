require 'spec_helper'

describe Main do
  it "get_unmatch return 10000" do
    target_array = (1..9999).to_a.shuffle
    expect(Main.new.get_unmatch(target_array)).to eq 10000
  end
end

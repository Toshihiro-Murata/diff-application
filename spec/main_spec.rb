require 'spec_helper'

def capture(stream)
    begin
        stream = stream.to_s
        eval "$#{stream} = StringIO.new"
        yield
        result = eval("$#{stream}").string
    ensure
        eval "$#{stream} = #{stream.upcase}"
    end
    result
end

describe Main do

  it "args_to_array returns Array object without nil values" do
    main = Main.new( '[1,2, 4 , 5, nil,]' )
    obj = main.send(:args_to_array)
    expect( obj.instance_of? Array ).to eq true
    expect( obj.length ).to eq 4
    expect( obj[0] ).to eq 1
    expect( obj[3] ).to eq 5
  end

  it "get exception if args_to_array recieves an invalid value" do
    ['','nil','false'].each do |val|
      expect do
        main = Main.new(val)
        main.send(:args_to_array)
      end.to raise_error( RuntimeError, "Invalid value for args_to_array(): #{val}!" )
    end
    
    ['[','*'].each do |val|
      expect do
        main = Main.new(val)
        main.send(:args_to_array)
      end.to raise_error( SyntaxError, "Invalid value for args_to_array(): #{val}!" )
    end
  end

  it "get_unmatch return 10000" do
    target_array = (1..9999).to_a.shuffle
    main = Main.new(target_array.to_s)
    expect( main.get_unmatch ).to eq 10000
  end

  it "get_unmatch return 1" do
      target_array = Array.new()
      (1..10000).to_a.shuffle.each do |i|
        target_array.push(i) unless i == 1
      end
      main = Main.new(target_array.to_s)
      expect( main.get_unmatch ).to eq 1
  end

  it "get_unmatch return an unmatched value" do
      (1..100).to_a.each do |i|
        target_array = Array.new()
        (1..10000).to_a.shuffle.each do |j|
          target_array.push(j) unless i == j
        end
        main = Main.new(target_array.to_s)
        expect( main.get_unmatch ).to eq i
      end
  end

  it "get exception if target_array length is not 9999 but 9998" do
    target_array = (1..9998).to_a.shuffle
    expect do
      main = Main.new(target_array.to_s)
      main.get_unmatch
    end.to raise_error( RuntimeError, "Invalid parameter length: [#{target_array.length}]!" )
  end

  it "get exception if target_array length is not 9999 but 10001" do
    target_array = (1..10001).to_a.shuffle
    expect do
      main = Main.new(target_array.to_s)
      main.get_unmatch
    end.to raise_error( RuntimeError, "Invalid parameter length: [#{target_array.length}]!" )
  end

  it "file_to_array returns Array.to_s value by using a file text" do
    file_path = '.tmp_rspec_file_to_array_001'
    text = (1..9999).to_a.shuffle.to_s
    File.write(file_path, text)
    target_array = (1..9999).to_a.shuffle
    main = Main.new(target_array.to_s)
    text2 = main.send(:file_to_array, file_path)
    expect( text ).to eq text2
  end

  describe "Executing as a CLI" do
    it "ruby lib/main.rb t/sample.data returns 10000" do
      expect{ system('ruby lib/main.rb t/sample.data') }.to output(/^10000$/).to_stdout_from_any_process
    end

    it "ruby lib/main.rb t/{randam.data} returns a valid value" do
      no = 0
      (1..10000).to_a.shuffle.each do |unmatch_value|
        break if no == 10
        target_array = Array.new
        (1..10000).to_a.shuffle.each do |j|
          target_array.push(j) unless unmatch_value == j
        end
        file_path = "t/_sample.data.#{no}"
        File.write(file_path, target_array.to_s)
        expect{ system("ruby lib/main.rb #{file_path}") }.to output(/^#{unmatch_value}$/).to_stdout_from_any_process
        File.unlink file_path
        no += 1
      end
    end
  end # end -- describe "Executing as a CLI"

end

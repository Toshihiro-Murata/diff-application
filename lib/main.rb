class Main

  def initialize args
    @args = args
  end

  def get_unmatch 
    target_array = args_to_array()
    unless is_valid_length? target_array
      raise "Invalid parameter length: [#{target_array.length}]!"
    end

    full_set = (1..10000).to_a
    result = full_set - target_array
    result.first
  end

  private

  def args_to_array
    if @args[0] and File.exist? @args[0]
      @args = file_to_array(@args[0])
    end

    begin
      obj = eval(@args.to_s)
      raise "Invalid value for args_to_array(): #{@args}!" unless (obj and obj.instance_of? Array)
      return obj.compact
    rescue SyntaxError
      raise SyntaxError, "Invalid value for args_to_array(): #{@args}!"
    end
  end

  def file_to_array file_path
    return File.read(file_path)
  end

  def is_valid_length? target_array
    if target_array.length == 9999
      return true
    end
    false
  end

end

if __FILE__ == $0
    puts Main.new(ARGV).get_unmatch
end
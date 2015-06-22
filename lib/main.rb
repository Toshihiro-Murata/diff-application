class Main

  def get_unmatch target_array
    unless is_valid_length? target_array
      raise "Invalid parameter length!"
    end

    full_set = (1..10000).to_a
    result = full_set - target_array
    result.first
  end

  def args_to_array args_str
    begin
      obj = eval(args_str)
      raise "Invalid value for args_to_array(): #{args_str}!" unless (obj and obj.instance_of? Array)
      return obj.compact
    rescue SyntaxError => ex
      raise SyntaxError, "Invalid value for args_to_array(): #{args_str}!"
    end
  end

  private

  def is_valid_length? target_array
    if target_array.length == 9999
      return true
    end
    false
  end

end
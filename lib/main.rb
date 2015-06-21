class Main

  def get_unmatch target_array
    unless is_valid_length? target_array
      raise "Invalid parameter length!"
    end

    full_set = (1..10000).to_a
    result = full_set - target_array
    unless result.length == 1
      raise "Uknown error!"
    end

    result.first
  end

  private

  def is_valid_length? target_array
    if target_array.length == 9999
      return true
    end
    false
  end

end

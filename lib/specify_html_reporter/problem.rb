class Problem
  attr_reader :problem

  def initialize(example, file_path)
    @example = example
    @file_path = file_path
    @exception = @example.exception

    return if @exception.nil?

    @problem = @exception.class
  end
end

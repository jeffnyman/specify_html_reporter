require "active_support"
require "active_support/core_ext/numeric"

class Example
  def initialize(example)
    @example = example
    setup_execution_result
    setup_example_data
    setup_metadata
  end

  private

  def setup_execution_result
    @execution_result = @example.execution_result
    @run_time = @execution_result.run_time.round(5)
    @status = @execution_result.status.to_s
    @duration = @execution_result.run_time.to_s(:rounded, precision: 5)
  end

  def setup_example_data
    @example_group = @example.example_group.to_s
    @description = @example.description
    @full_description = @example.full_description
    @metadata = @example.metadata
  end

  def setup_metadata
    @file_path = @metadata[:file_path]
  end
end

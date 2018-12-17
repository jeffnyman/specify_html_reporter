require "active_support"
require "active_support/core_ext/numeric"

require "specify_html_reporter/problem"

class Example
  attr_reader :duration, :status, :run_time, :exception

  def initialize(example)
    @example = example
    setup_execution_result
    setup_example_data
    setup_metadata
    setup_exception
  end

  def result_type(prefix = 'label-')
    class_map = {
      passed: "#{prefix}success",
      failed: "#{prefix}danger",
      pending: "#{prefix}warning"
    }

    class_map[@status.to_sym]
  end

  def example_title
    full_title = @example_group.to_s.split('::') - %w[RSpec ExampleGroups]
    full_title.push @description
    full_title.join(' → ')
  end

  def exception?
    !@exception.problem.nil?
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

  def setup_exception
    @exception = Problem.new(@example, @file_path)
  end
end

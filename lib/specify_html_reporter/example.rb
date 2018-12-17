require "rouge"
require "active_support"
require "active_support/core_ext/numeric"

require "specify_html_reporter/problem"

class Example
  attr_reader :duration, :status, :run_time, :exception, :file_path,
    :metadata, :spec

  def initialize(example)
    @spec = nil
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

  def spec?
    !@spec.nil?
  end

  def comment
    ERB::Util.html_escape(@comment)
  end

  def comment?
    !@comment.nil?
  end

  def create_spec_line(spec_text)
    formatter = Rouge::Formatters::HTML.new(css_class: 'highlight')
    lexer = Rouge::Lexers::Gherkin.new
    @spec = formatter.format(lexer.lex(spec_text.gsub('#->', '')))
  end

  def self.load_spec_comments!(examples)
    examples.group_by(&:file_path).each do |file_path, file_examples|
      lines = File.readlines(file_path)

      file_examples.zip(file_examples.rotate).each do |example, next_ex|
        determine_lexical_next(example, next_ex)
        process_spec_lines(example, next_ex, lines)
      end
    end
  end

  private

  class << self
    private

    def determine_lexical_next(example, next_ex)
      @lexical = next_ex &&
                 next_ex.file_path == example.file_path &&
                 next_ex.metadata[:line_number] > example.metadata[:line_number]
    end

    def process_spec_lines(example, next_ex, lines)
      start_line = example.metadata[:line_number] - 1
      next_start = (@lexical ? next_ex.metadata[:line_number] : lines.size) - 1
      spec_lines = lines[start_line...next_start].select { |l| l.match(/#->/) }
      example.create_spec_line(spec_lines.join) unless spec_lines.empty?
    end
  end

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
    @comment = @metadata[:comment]
  end

  def setup_exception
    @exception = Problem.new(@example, @file_path)
  end
end

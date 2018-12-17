require "rouge"
require "rbconfig"

class Problem
  attr_reader :problem, :explanation, :backtrace_message, :highlighted_source

  def initialize(example, file_path)
    @example = example
    @file_path = file_path
    @exception = @example.exception

    return if @exception.nil?

    @problem = @exception.class
    @message = @exception.message.encode("utf-8")
    @backtrace_message = format_backtrace
    @highlighted_source = format_source
    @explanation = format_message
  end

  def format_message
    formatter = Rouge::Formatters::HTML.new(css_class: 'highlight')
    lexer = Rouge::Lexers::Ruby.new
    formatter.format(lexer.lex(@message))
  end

  def format_backtrace
    formatted_backtrace(@example, @exception).map do |entry|
      ERB::Util.html_escape(entry)
    end
  end

  def formatted_backtrace(example, exception)
    # This logic is in place to avoid an error in the format_backtrace method
    # for the RSpec formatter. RSpec versions below 3.5 will throw an exception.
    return [] unless example

    formatter = RSpec.configuration.backtrace_formatter
    formatter.format_backtrace(exception.backtrace, example.metadata)
  end

  def format_source
    return '' if @backtrace_message.empty?

    data = @backtrace_message.first.split(':')

    return if data.empty?

    if os == :windows
      file_path = data[0] + ':' + data[1]
      line_number = data[2].to_i
    else
      file_path = data.first
      line_number = data[1].to_i
    end

    format_source_context(file_path, line_number)
  end

  def format_source_context(file_path, line_number)
    lines = File.readlines(file_path)
    start_line = line_number - 2
    end_line = line_number + 3

    source = lines[start_line..end_line].join("")

    formatter = Rouge::Formatters::HTML.new(
      css_class: 'highlight', line_numbers: true, start_line: start_line + 1
    )

    lexer = Rouge::Lexers::Ruby.new
    formatter.format(lexer.lex(source.encode('utf-8')))
  end

  def os
    @os ||= begin
      host_os = RbConfig::CONFIG['host_os']

      case host_os
        when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
          :windows
        when /darwin|mac os/
          :macosx
        when /linux/
          :linux
        when /solaris|bsd/
          :unix
        else
          raise Exception, "Unknown operating system: #{host_os.inspect}"
      end
    end
  end
end

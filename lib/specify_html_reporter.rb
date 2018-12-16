require "specify_html_reporter/version"

require "rspec/core/formatters/base_formatter"

class SpecifyHtmlReport < RSpec::Core::Formatters::BaseFormatter
  ::RSpec::Core::Formatters.register self,
    :example_group_started, :example_group_finished, :example_started,
    :example_passed, :example_failed, :example_pending

  REPORT_PATH = ENV['REPORT_PATH'] || 'reports'

  def initialize(_output)
    create_report_directory
    provide_report_resources

    @group_level = 0
  end

  def example_group_started(_notification)
    return unless @group_level.zero?

    @examples = []
    @group_example_count = 0
    @group_example_success_count = 0
    @group_example_failure_count = 0
    @group_example_pending_count = 0

    @group_level += 1
  end

  def example_group_finished(_notification)
    @group_level -= 1
    return unless @group_level.zero?
  end

  def example_started(_notification)
    @group_example_count += 1
  end

  def example_passed(notification)
    @group_example_success_count += 1
    @examples << notification.example
  end

  def example_failed(notification)
    @group_example_failure_count += 1
    @examples << notification.example
  end

  def example_pending(notification)
    @group_example_pending_count += 1
    @examples << notification.example
  end

  private

  def create_report_directory
    FileUtils.rm_rf(REPORT_PATH) if File.exist?(REPORT_PATH)
    FileUtils.mkpath(REPORT_PATH)
  end

  def provide_report_resources
    FileUtils.cp_r(
      File.dirname(__FILE__) + "/../resources", REPORT_PATH
    )
  end
end

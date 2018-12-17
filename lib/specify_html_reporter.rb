require "erb"
require "rouge"
require "fileutils"
require "specify_html_reporter/version"
require "specify_html_reporter/example"

require "rspec/core/formatters/base_formatter"

class SpecifyHtmlReport < RSpec::Core::Formatters::BaseFormatter
  ::RSpec::Core::Formatters.register self,
    :example_group_started, :example_group_finished, :example_started,
    :example_passed, :example_failed, :example_pending

  REPORT_PATH = ENV['REPORT_PATH'] || 'reports'

  def initialize(_output)
    create_report_directory
    provide_report_resources

    @group_collection = {}
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

  def example_group_finished(notification)
    @group_level -= 1
    return unless @group_level.zero?

    group_file = notification.group.description.parameterize

    File.open("#{REPORT_PATH}/#{group_file}.html", "w") do |f|
      report_file = File.read(
        File.dirname(__FILE__) + "/../templates/report.erb"
      )

      f.puts ERB.new(report_file).result(binding)
    end
  end

  def example_started(_notification)
    @group_example_count += 1
  end

  def example_passed(notification)
    @group_example_success_count += 1
    @examples << Example.new(notification.example)
  end

  def example_failed(notification)
    @group_example_failure_count += 1
    @examples << Example.new(notification.example)
  end

  def example_pending(notification)
    @group_example_pending_count += 1
    @examples << Example.new(notification.example)
  end

  def close(_notification)
    File.open("#{REPORT_PATH}/overview.html", "w") do |f|
      @overview = @group_collection

      overview_results
      overview_durations

      @total_examples = @passed + @failed + @pending

      overview_file = File.read(
        File.dirname(__FILE__) + "/../templates/overview.erb"
      )

      f.puts ERB.new(overview_file).result(binding)
    end
  end

  private

  def overview_results
    overview_results_passed
    overview_results_failed
    overview_results_pending
  end

  def overview_results_passed
    @passed = @overview.values
                       .map { |g| g[:passed].size }
                       .inject(0) { |sum, i| sum + i }
  end

  def overview_results_failed
    @failed = @overview.values
                       .map { |g| g[:failed].size }
                       .inject(0) { |sum, i| sum + i }
  end

  def overview_results_pending
    @pending = @overview.values
                        .map { |g| g[:pending].size }
                        .inject(0) { |sum, i| sum + i }
  end

  def overview_durations
    duration_values = @overview.values.map { |e| e[:duration] }
    duration_keys = duration_values.size.times.to_a

    @durations = duration_keys.zip(
      duration_values.map { |d| d.to_f.round(5) }
    )

    @summary_duration = duration_values
                        .map { |d| d.to_f.round(5) }
                        .inject(0) { |sum, i| sum + i }
                        .to_s(:rounded, precision: 5)
  end

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

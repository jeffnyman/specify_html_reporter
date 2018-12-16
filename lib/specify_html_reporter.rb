require "specify_html_reporter/version"

require "rspec/core/formatters/base_formatter"

class SpecifyHtmlReport < RSpec::Core::Formatters::BaseFormatter
  ::RSpec::Core::Formatters.register self

  REPORT_PATH = ENV['REPORT_PATH'] || 'reports'

  def initialize(_output)
    create_report_directory
    provide_report_resources

    @group_level = 0
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

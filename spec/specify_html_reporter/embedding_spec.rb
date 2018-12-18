RSpec.describe "Embedded resources are supported" do
  before(:all) do
    report_dir = SpecifyHtmlReport::REPORT_PATH

    FileUtils.cp './spec/support/calculator.png', "#{report_dir}/screen_grabs/"
    FileUtils.cp './spec/support/calculator.mp4', "#{report_dir}/video_records/"
  end

  context "screenshots" do
    it "includes a screen grab with a passing example" do |example|
      example.metadata[:screen_grab] = []

      example.metadata[:screen_grab] << {
        caption: "Calculator",
        path: "./screen_grabs/calculator.png"
      }

      expect("testing").to eq "testing"
    end
  end

  context "videos" do
    it "includes a video record with a passing example" do |example|
      example.metadata[:video_record] = "./video_records/calculator.mp4"

      expect("testing").to eq "testing"
    end
  end
end

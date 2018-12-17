RSpec.describe "Commented examples are supported" do
  before(:each) do |example|
    example.metadata[:comment] = "A default comment for each test."
  end

  it "will use the default comment for passing tests" do
    expect("testing").to eq "testing"
  end

  it "will override a specific comment" do |example|
    example.metadata[:comment] = "A specific comment for one test."
    expect("testing").to eq "testing"
  end
end

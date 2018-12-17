RSpec.describe "Inline styles are supported" do
  it "will allow inline test specification (passing test)" do
    #-> Given some context
    #-> When  an action is taken
    #-> Then  a result is observed
    expect("test").to eq "test"
  end

  it "will allow inline test specification (interleaved)" do
    #-> Given some context
    expect("test").to eq "test"

    #-> When an action is taken
    expect("testing").to eq "testing"

    #-> Then a result is observed
    expect("qa").to eq "qa"
  end

  it "will allow inline test specification (non-Gherkin)" do
  	#-> This test requires someone understanding that testing
	  #-> and quality assurance are not the same thing.
    expect("qa").not_to eq "testing"
  end
end

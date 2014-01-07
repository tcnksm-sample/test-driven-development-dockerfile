require "spec_helper"

describe "Sample Images" do

  before(:all) do
    @image = Docker::Image.all.detect{|image| image.info["Repository"] == "tcnksm/sample"}
    puts @image.json
  end

  it "should exist" do
    expect(@image).not_to be_nil
  end

  it "should expose the default port" do
    expect(@image.json["config"]["ExposedPorts"].has_key?("22/tcp")).to be_true
  end
end

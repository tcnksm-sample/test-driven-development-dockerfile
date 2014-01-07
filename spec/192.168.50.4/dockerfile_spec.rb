require "spec_helper"

describe "Sample Images" do

  before(:all) do
    @image = Docker::Image.all.detect{|image| image.info["Repository"] == "tcnksm/sample"}
  end

  it "should exist" do
    expect(@image).not_to be_nil
  end

  it "should expose the default port" do
    expect(@image.json["config"]["ExposedPorts"].has_key?("22/tcp")).to be_true
  end

  it "should have CMD" do
    expect(@image.json["config"]["Cmd"]).to include("sshd")
  end

  it "should have working directory" do
    expect(@image.json["config"]["WorkingDir"]).to eq("/home/taichi")
  end

  it "should have environmental variable" do
    expect(@image.json["config"]["Env"]).to include("TEST=test")
  end
end

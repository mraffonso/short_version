require "../../spec_helper"
require "../../../src/short_version/ext/semantic_version"

describe SemanticVersion do
  it "parses SemanticVersion" do
    shortver = ShortVersion.new(3, 14)
    SemanticVersion.parse(shortver).should eq SemanticVersion.new(3, 14, 0)
  end

  it "converts to short version" do
    SemanticVersion.new(1, 2, 0).to_shortver.should eq ShortVersion.new(1, 2)
  end

  it "compares < with short version" do
    SemanticVersion.new(1, 1, 0).should be < ShortVersion.new(2, 0)
    SemanticVersion.new(1, 1, 0).should be < ShortVersion.new(1, 2)
    SemanticVersion.new(1, 1, 0).should_not be < ShortVersion.new(1, 1)
  end

  it "compares equivalence with semantic version" do
    SemanticVersion.new(2, 7, 0).should eq ShortVersion.new(2, 7)
    SemanticVersion.new(2, 7, 1).should eq ShortVersion.new(2, 7)
    SemanticVersion.new(3, 0, 0).should_not eq ShortVersion.new(2, 7)
    SemanticVersion.new(2, 8, 0).should_not eq ShortVersion.new(2, 7)
  end

  it "compares > with semantic version" do
    SemanticVersion.new(2, 0, 0).should be > ShortVersion.new(1, 0)
    SemanticVersion.new(2, 1, 0).should be > ShortVersion.new(2, 0)
    SemanticVersion.new(2, 1, 1).should_not be > ShortVersion.new(2, 1)
  end
end

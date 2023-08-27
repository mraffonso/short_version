require "./spec_helper"

describe ShortVersion do
  it "parses short version string" do
    ShortVersion.parse("3.1").should eq ShortVersion.new(3, 1)

    expect_raises(ArgumentError, "Not a short version: \"invalid\"") do
      ShortVersion.parse("invalid")
    end
  end

  it "parses SemanticVersion" do
    semver = SemanticVersion.new(3, 14, 0)
    ShortVersion.parse(semver).should eq ShortVersion.new(3, 14)
  end

  it "converts to string" do
    ShortVersion.new(2, 2).to_s.should eq "2.2"
  end

  it "converts to semantic version" do
    semver = SemanticVersion.new(2, 2, 0)
    ShortVersion.new(2, 2).to_semver.should eq semver
  end

  it "compares <" do
    ShortVersion.new(2, 0).should be < ShortVersion.new(3, 0)
    ShortVersion.new(2, 1).should be < ShortVersion.new(2, 2)
  end

  it "compares < with semanntic version" do
    ShortVersion.new(2, 0).should be < SemanticVersion.new(3, 0, 0)
    ShortVersion.new(2, 1).should be < SemanticVersion.new(2, 2, 0)
    ShortVersion.new(2, 1).should_not be < SemanticVersion.new(2, 1, 1)
  end

  it "compares equivalence" do
    ShortVersion.new(2, 7).should eq ShortVersion.new(2, 7)
    ShortVersion.new(2, 7).should_not eq ShortVersion.new(2, 8)
  end

  it "compares equivalence with semantic version" do
    ShortVersion.new(2, 7).should eq SemanticVersion.new(2, 7, 0)
    ShortVersion.new(2, 7).should eq SemanticVersion.new(2, 7, 1)
    ShortVersion.new(2, 7).should_not eq SemanticVersion.new(2, 8, 0)
  end

  it "compares >" do
    ShortVersion.new(2, 0).should be > ShortVersion.new(1, 0)
    ShortVersion.new(2, 1).should be > ShortVersion.new(2, 0)
  end

  it "compares > with semantic version" do
    ShortVersion.new(2, 0).should be > SemanticVersion.new(1, 0, 0)
    ShortVersion.new(2, 1).should be > SemanticVersion.new(2, 0, 0)
    ShortVersion.new(2, 1).should_not be > SemanticVersion.new(2, 1, 1)
  end

  it "does not accept bad versions" do
    sversions = %w(
      1
      1.2.3-0123
      1.2.3-0123.0123
      0.0.4--.
      1.1.2+.123
      +invalid
      -invalid
      -invalid+invalid
      -invalid.01
      alpha
      alpha.beta
      alpha.beta.1
      alpha.1
      alpha+beta
      alpha_beta
      alpha.
      alpha..
      1.0.0-alpha_beta
      -alpha.
      1.0.0-alpha..
      1.0.0-alpha..1
      1.0.0-alpha...1
      01.1.1
      1.01.1
      1.1.01
      1.2.3.DEV
      1.2-SNAPSHOT
      1.2.31.2.3----RC-SNAPSHOT.12.09.1--..12+788
      1.2-RC-SNAPSHOT
      -1.0.3-gamma+b7718
      +justmeta
      9.8.7+meta+meta
      9.8.7-whatever+meta+meta
      99999999999999999999999.999999999999999999.99999999999999999----RC-SNAPSHOT.12.09.1--------------------------------..12
    )
    sversions.each do |s|
      expect_raises(ArgumentError) { ShortVersion.parse(s) }
    end
  end

  it "copies with specified modifications" do
    base_version = ShortVersion.new(1, 2)
    base_version.copy_with(major: 0).should eq ShortVersion.new(0, 2)
    base_version.copy_with(minor: 0).should eq ShortVersion.new(1, 0)
  end

  it "bumps to the correct version" do
    ShortVersion.new(1, 2).bump_major.should eq ShortVersion.new(2, 0)
    ShortVersion.new(1, 2).bump_minor.should eq ShortVersion.new(1, 3)
  end
end

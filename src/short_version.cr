require "semantic_version"

# Conforms to Short Versioning
#
# Similar to [Semantic Versioning](https://semver.org/) but only with major and minor version numbers.
struct ShortVersion
  include Comparable(self)
  include Comparable(SemanticVersion)

  # The major version of this short version
  getter major : Int32

  # The minor version of this short version
  getter minor : Int32

  # Parses a `ShortVersion` from the given short version string.
  #
  # ```
  # require "short_version""
  #
  # shortver = ShortVersion.parse("2.61")
  # shortver # => ShortVersion(@major=2, @minor=61)
  # ```
  #
  # Raises `ArgumentError` if *str* is not a short version.
  def self.parse(version : String) : self
    if m = version.match(/^(\d+)\.(\d+).?$/)
      values = version.strip.split(".")
      major = m[1].to_i
      minor = m[2].to_i
      new major, minor
    else
      raise ArgumentError.new("Not a short version: #{version.inspect}")
    end
  end

  # Parses a `ShortVersion` from the given `SemanticVersion`.
  #
  # ```
  # require "short_version""
  #
  # semver = SemanticVersion.parse("2.61.9")
  # shortver = ShortVersion.parse(semver)
  # shortver # => ShortVersion(@major=2, @minor=61)
  # ```
  def self.parse(version : SemanticVersion) : self
    new(version.major, version.minor)
  end

  # Creates a new `ShortVersion` instance with the given major and minor
  # version.
  def initialize(@major : Int, @minor : Int)
  end

  # Returns the string representation of this short version
  #
  # ```
  # require "short_version"
  #
  # shortver = ShortVersion.parse("0.27")
  # shortver.to_s # => "0.27"
  # ```
  def to_s(io : IO) : Nil
    io << major << '.' << minor
  end

  # Returns the `SemanticVersion` representation of this short version
  #
  # ```
  # require "short_version"
  #
  # shortver = ShortVersion.parse("0.27")
  # shortver.to_semver # => SemanticVersion(@major=0, @minor=27, @patch=0, ...)
  # ```
  def to_semver(patch : Int = 0) : SemanticVersion
    SemanticVersion.new major: major, minor: minor, patch: patch
  end

  # Returns a new `ShortVersion` created with the specified parts. The
  # default for each part is its current value.
  #
  # ```
  # require "short_version"
  #
  # current_version = ShortVersion.parse("1.1")
  # current_version.copy_with(minor: 2) # => ShortVersion(@major=1, @minor=2)
  # ```
  def copy_with(major : Int32 = @major, minor : Int32 = @minor)
    ShortVersion.new major, minor
  end

  # Returns a copy of the current version with a major bump.
  #
  # ```
  # require "short_version"
  #
  # shortver = ShortVersion.parse("1.1")
  # shortver.bump_major # => ShortVersion(@major=2, @minor=0)
  # ```
  def bump_major
    copy_with(major: major + 1, minor: 0)
  end

  # Returns a copy of the current version with a minor bump.
  #
  # ```
  # require "short_version"
  #
  # shortver = ShortVersion.parse("1.1")
  # shortver.bump_minor # => ShortVersion(@major=1, @minor=2)
  # ```
  def bump_minor
    copy_with(minor: minor + 1)
  end

  # The comparison operator with self.
  #
  # Returns `-1`, `0` or `1` depending on whether `self`'s version is lower than *other*'s,
  # equal to *other*'s version or greater than *other*'s version.
  #
  # ```
  # require "short_version"
  #
  # ShortVersion.parse("1.0") <=> ShortVersion.parse("2.0") # => -1
  # ShortVersion.parse("1.0") <=> ShortVersion.parse("1.0") # => 0
  # ShortVersion.parse("2.0") <=> ShortVersion.parse("1.0") # => 1
  # ```
  def <=>(other : self) : Int32
    r = major <=> other.major
    return r unless r.zero?
    r = minor <=> other.minor
    return r unless r.zero?

    0
  end

  # The comparison operator with SemanticVersion.
  #
  # Returns `-1`, `0` or `1` depending on whether `self`'s version is lower than *other*'s,
  # equal to *other*'s version or greater than *other*'s version.
  #
  # ```
  # require "short_version"
  #
  # ShortVersion.parse("1.0") <=> SemanticVersion.parse("2.0.0") # => -1
  # ShortVersion.parse("1.0") <=> SemanticVersion.parse("1.0.0") # => 0
  # ShortVersion.parse("1.0") <=> SemanticVersion.parse("0.1.0") # => 1
  # ```
  def <=>(other : SemanticVersion) : Int32
    r = major <=> other.major
    return r unless r.zero?
    r = minor <=> other.minor
    return r unless r.zero?

    0
  end
end

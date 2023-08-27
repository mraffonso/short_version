struct SemanticVersion
  include Comparable(ShortVersion)

  # Parses a `SemanticVersion` from the given `ShortVersion`
  #
  # ```
  # require "short_version/ext/semantic_version"
  #
  # shortver = ShortVersion.parse("1.23")
  # semver = SemanticVersion.parse(shortver)
  # semver # => SemanticVersion(@major=1, @minor=23, @patch=0, ... )
  # ```
  def self.parse(str : ShortVersion) : self
    major = str.major
    minor = str.minor
    new major, minor, 0
  end

  # Returns the `ShortVersion` representation of this semantic version
  #
  # ```
  # require "short_version/ext/semantic_version"
  #
  # semver = SemanticVersion.parse("0.39.3")
  # semver.to_shortver # => ShortVersion(@major=0, @minor=39)
  # ```
  def to_shortver
    ShortVersion.new(major, minor)
  end

  # The comparison operator with ShortVersion.
  #
  # Returns `-1`, `0` or `1` depending on whether `self`'s version is lower than *other*'s,
  # equal to *other*'s version or greater than *other*'s version.
  #
  # ```
  # require "short_version/ext/semantic_version"
  #
  # SemanticVersion.parse("1.2.3") <=> ShortVersion.parse("1.3") # => -1
  # SemanticVersion.parse("1.2.3") <=> ShortVersion.parse("1.2") # => 0
  # SemanticVersion.parse("1.2.3") <=> ShortVersion.parse("1.1") # => 1
  # ```
  def <=>(other : ShortVersion) : Int32
    r = major <=> other.major
    return r unless r.zero?
    r = minor <=> other.minor
    return r unless r.zero?

    0
  end
end

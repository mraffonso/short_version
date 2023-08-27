# short_version

Based on [SemanticVersion] from the standard library but with only major and minor versions. It is comparable with and convertible to [SemanticVersion] and has an optional extension that adds convenience functionality to [SemanticVersion].

## Installation

1. Add the dependency to your `shard.yml`

```yaml
dependencies:
  short_version:
    github: mraffonso/short_version
```

2. Run `shards install`

## Usage

Require the library.

```crystal
require "short_version"
```

Create a [ShortVersion].

```crystal
ShortVersion.new(1, 1)
# => ShortVersion(@major=1, @minor=1)
ShortVersion.new(major: 2, minor: 3)
# => ShortVersion(@major=2, @minor=3)
````

OR `parse` from another format: `String` or `SemanticVersion`.

```crystal
ShortVersion.parse("1.1")
# => ShortVersion(@major=1, @minor=1)

semver = SemanticVersion.new(1, 1, 2)
ShortVersion.parse(semver)
# => ShortVersion(@major=1, @minor=1)
````

Convert [ShortVersion] to [SemanticVersion]. **Note**: The patch version will always be `0`.

```crystal
shortver = ShortVersion.parse("1.1")
shortver.to_semver # => SemanticVersion(@major=1, @minor=1, @patch=0, ...)
```

Compare [ShortVersion] <=> [ShortVersion].

```crystal
ShortVersion.parse("1.2") < ShortVersion.parse("1.3") # => true
ShortVersion.parse("1.2") == ShortVersion.parse("1.2") # => true
ShortVersion.parse("1.2") > ShortVersion.parse("1.1") # => true
```

Compare [ShortVersion] <=> [SemanticVersion].

```crystal
ShortVersion.parse("1.2") < SemanticVersion.parse("1.3.0") # => true
ShortVersion.parse("1.2") == SemanticVersion.parse("1.2.3") # => true
ShortVersion.parse("1.2") > SemanticVersion.parse("1.1.19") # => true
```

### Extending SemanticVersion (Optional)

This extension is unnecessary but it adds some nice convenience and may allow your code to flow more naturally.

**Note**: It extends the [SemanticVersion] Struct from the standard library by adding a `to_shortver` instance method and `Comparable(ShortVersion)` functionality.

Require the extension.

```crystal
require "short_version/ext/semantic_version"
```

Convert a [SemanticVersion] to [ShortVersion].

```crystal
semver = SemanticVersion.parse("1.2.3")
semver.to_shortver # => ShortVersion(@major=1, @minor=2)

# Without the extension
ShortVersion.parse(semver) # => ShortVersion(@major=1, @minor=2)
```

Compare [SemanticVersion] <=> [ShortVersion].

```crystal
SemanticVersion.parse("1.2.3") < ShortVersion.parse("1.3") # => true
SemanticVersion.parse("1.2.3") == ShortVersion.parse("1.2") # => true
SemanticVersion.parse("1.2.3") > ShortVersion.parse("1.1") # => true

# Without the extension comparison must be reversed
ShortVersion.parse("1.1") < SemanticVersion.parse("1.2.3") # => true
ShortVersion.parse("1.2") == SemanticVersion.parse("1.2.3") # => true
ShortVersion.parse("1.3") > SemanticVersion.parse("1.2.3") # => true
```

## Contributing

1. Fork it (<https://github.com/mraffonso/short_version/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Mario Affonso](https://github.com/mraffonso) - creator and maintainer

[ShortVersion]: https://github.com/mraffonso/short_version
[SemanticVersion]: https://crystal-lang.org/api/SemanticVersion.html

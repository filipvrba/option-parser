# OptionParser
A class for command-line options processing.

## Make and install gem pack
```bash
gem build option_parser.gemspec
gem install option_parser-1.0.0.gem
```

## Example
```ruby
require "option_parser"

OptionParser.parse do |parser|
    parser.banner( "This is test app" )
    parser.on( "-h", "--help", "Show help" ) do
        puts parser
    end
    parser.on( "-v", "--version", "Show version" ) do
        puts "Version is 1.0.0"
    end
    parser.on( "-o", "--open", "This argument, opened an file." ) do |name|
        puts "Opening file..."
        File.open( name ) do |data|
            puts data.read
        end
    end
end
```
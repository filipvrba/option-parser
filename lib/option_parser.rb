class OptionParser

    NAME = "NAME"
    attr_reader :args

    def self.parse(args = ARGV)
        parser = OptionParser.new
        yield parser
        parser.process args
        parser
    end

    def initialize(args = ARGV)
        @args = args
        @banner = nil
        @flags = Array.new
    end

    def banner(banner)
        @banner = banner
    end

    def on(flag, description, &block)
        on( flag, nil, description, block )
    end

    def on(short_flag, long_flag, description, &block)
        @flags << { short_flag: short_flag, long_flag: long_flag,
            description: description, block: block }
    end

    def process( args = ARGV )
        args.each_with_index do |arg, i|
            @flags.each do |flag|

                flag_strip = -> (type_flag) { flag[type_flag].sub( NAME, '' ).strip() }
                has_flag = -> (type_flag) { arg == flag_strip.(type_flag) }

                if has_flag.(:short_flag) or
                   has_flag.(:long_flag)

                    has_name = -> (type_flag) { flag[type_flag].index( NAME ) != nil }
                    value = nil
                    if has_name.(:short_flag) or
                       has_name.(:long_flag)
                        value = args[i + 1]
                    end

                    flag[:block].call( value )
                end
            end
        end
    end

    def to_s()
        io = Array.new
        if banner = @banner
            io << banner
            io << "\n"
        end
        
        @flags.each do |flag|
            io << "".ljust(4) + "#{flag[:short_flag]}, #{flag[:long_flag]}".ljust(33) + flag[:description]
            io << "\n"
        end

        io.join
    end
end

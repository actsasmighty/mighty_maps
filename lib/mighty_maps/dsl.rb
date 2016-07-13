require "erb"

module MightyMaps
  module DSL
    def self.included(base)
      class << base
        alias :original_name :name
      end

      base.extend(ClassMethods)
    end

    module ClassMethods
      def block(options = {}, &block_param)
        class_variable_set(:@@blocks, []) unless class_variable_defined?(:@@blocks)
        blocks = class_variable_get(:@@blocks)
        new_block = MightyMaps::Types::Block.new(options)
        new_block.instance_exec(&block_param)
        blocks << new_block
        class_variable_set(:@@blocks, blocks) # should not be needed because we modify the array in place
        self
      end

      def blocks
        class_variable_get(:@@blocks)
      end

      # there is a ruby method Class.name, which is aliased to :original_name
      def name(*args)
        case args.length
        when 0 then class_variable_get(:@@name)
        when 1 then class_variable_set(:@@name, args.first.to_s)
        else raise ArgumentError
        end
      end

      def to_ruby(options = {})
        template = <<-eor
          require "mighty_maps"
          __nl__
          class #{original_name}
            include MightyMaps::DSL
            __nl__
            name "#{name}"
            <% blocks.each do |block| %>
            __nl__
            <% if options[:blocks] && options[:blocks].to_sym == :verbose %>
            block do
              <% if block.name %>name "<%= block.name %>"<% end %>
              <% if block.description %>description "<%= block.description %>"<% end %>
              __nl__
            <% else %>
            block name: <%= block.name %>, description: <%= block.description %> do
            <% end %>
              <% block.seats.each do |seat| %>
              seat x: <%= seat.x.to_s %>, y: <%= seat.y.to_s %>, row: <%= seat.row ? '"' + seat.row.to_s + '"' : "nil" %>, number: <%= seat.number ? '"' + seat.number.to_s + '"' : "nil" %>
              <% end %>
            end
            <% end %>
          end
        eor

        # adapted from ActiveSupport's strip_heredoc
        indent = template.scan(/^[ \t]*(?=\S)/).min.size
        template = template.gsub(/^[ \t]{#{indent}}/, "")

        # the following is just for aestetic reasons
        ERB.new(template).result(binding)
        .split("\n")
        .map do |line|
          line[/\A\s+\Z/] ? "" : line # make empty lines uniform ""
        end
        .join("\n")
        .gsub(/\n+/, "\n")
        .gsub("__nl__\n", "\n")
      end
    end
  end
end

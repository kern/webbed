require "treetop"

module Webbed
  module Grammars
    # `Loader` loads Treetop grammar files into webbed. It implements an
    # interface similar to that of Ruby's `require` method, but rather than
    # working with Ruby files, it works with Treetop grammars.
    #
    # @author Alex Kern
    # @api public
    module Loader
      # Path to the folder containing webbed's grammars.
      LOAD_PATH = File.expand_path("../", __FILE__)

      @loaded_grammars = []

      # Requires a grammar by name.
      #
      # @param [String] name the name of the grammar
      # @return [Boolean] whether or not the grammar was loaded
      # @raise [LoadError] if the grammar was not found
      def self.require(name)
        if @loaded_grammars.include?(name)
          false
        else
          Treetop.load("#{LOAD_PATH}/#{name}")
          @loaded_grammars << name
          true
        end
      rescue Errno::ENOENT => e
        raise LoadError.new(e.message)
      end

      # Clears the list of loaded grammars.
      def self.clear_loaded_grammars
        @loaded_grammars = []
      end
    end
  end
end

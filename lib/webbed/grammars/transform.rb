require "parslet"

module Webbed
  module Grammars
    # `Transform` is an extension of Parslet's transforms, allowing you to
    # specify default contexts on the entire class or the individual instances
    # of the transform. This allows you to use dependency injection is a
    # pricipled way.
    class Transform < Parslet::Transform
      # Sets the class context of the transform.
      #
      # The result of the block is used as the class context. It is run on the
      # initialization of each instance.
      #
      # This context will be overridden by instance and application contexts if
      # there are any key conflicts.
      #
      # @yieldreturn [Hash, #merge] the class context
      def self.context(&block)
        @context = block if block_given?
        @context || lambda {}
      end

      # Creates a new transform.
      #
      # You may optionally provide an instance context to this method. This
      # context will apply to all applied transformations done by this instance.
      # It will be overridden by application contexts if there are any key
      # conflicts.
      #
      # @param [Hash, #merge] instance_context the instance context
      # @yield Runs in the metaclass of the instance.
      def initialize(instance_context = {}, &block)
        super(&block)
        @class_context = self.class.context.call
        @instance_context = instance_context
      end

      # Applies the transformation to an object.
      #
      # The optional application context will override the class and instance
      # contexts if there are any key conflicts.
      #
      # @param [Object] the object to apply the transformation to
      # @param [Hash, #merge] the application context
      def apply(obj, application_context = {})
        super(obj, merge_contexts(application_context))
      end

      private

      # Merges the application, instance, and class contexts together.
      #
      # @param [Hash, #merge] application_context the application context
      def merge_contexts(application_context)
        @class_context.merge(@instance_context.merge(application_context))
      end
    end
  end
end

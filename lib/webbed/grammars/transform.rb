require "parslet"

module Webbed
  module Grammars
    class Transform < Parslet::Transform
      def self.context(&block)
        @context = block if block_given?
        @context || lambda {}
      end

      def initialize(instance_context = {}, &block)
        super(&block)
        @class_context = self.class.context.call
        @instance_context = instance_context
      end

      def apply(obj, application_context = {})
        super(obj, merge_contexts(application_context))
      end

      private

      def merge_contexts(application_context)
        @class_context.merge(@instance_context.merge(application_context))
      end
    end
  end
end

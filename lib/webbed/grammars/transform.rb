require "parslet"

module Webbed
  module Grammars
    class Transform < Parslet::Transform
      def self.context(hash = nil)
        @context = hash if hash
        @context || {}
      end

      def initialize(instance_context = {}, &block)
        super(&block)
        @instance_context = instance_context
      end

      def apply(obj, application_context = {})
        super(obj, merge_contexts(application_context))
      end

      private

      def class_context
        self.class.context
      end

      def merge_contexts(application_context)
        class_context.merge(@instance_context.merge(application_context))
      end
    end
  end
end

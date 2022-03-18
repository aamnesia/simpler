module Simpler
  class View

    class Plain
      def initialize(template)
        @template = template
      end

      def result(_binding)
        @template[:plain]
      end
    end

  end
end

module Todo
  module UseCases
    class UseCase
      def self.perform(*args)
        new(persistence: Persistence.new).perform(*args)
      end

      def initialize(persistence:)
        @persistence = persistence
      end
    end
  end
end

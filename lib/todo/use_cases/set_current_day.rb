module Todo
  module UseCases
    class SetCurrentDay
      def initialize(new_day: nil, persistence: Persistence.new)
        @new_day = new_day
        @persistence = persistence
      end

      def perform
        persistence.write_current_day(formatted_new_day) if @new_day
        persistence.read_current_day
      end

      private

      def formatted_new_day
        DayFormatter.new(@new_day).format
      end

      attr_reader :persistence
    end
  end
end

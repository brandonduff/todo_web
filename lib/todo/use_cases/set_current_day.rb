module Todo
  module UseCases
    class SetCurrentDay
      def initialize(options)
        @new_day = options[:new_day]
      end

      def perform
        persistence.write_current_day(formatted_new_day) if @new_day
        persistence.read_current_day
      end

      private

      def persistence
        Persistence.new
      end

      def formatted_new_day
        DayFormatter.new(@new_day).format
      end
    end
  end
end

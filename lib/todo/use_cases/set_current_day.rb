module Todo
  module UseCases
    class SetCurrentDay
      def initialize(new_day: nil, notepad: Notepad.new)
        @new_day = new_day
        @notepad = notepad
      end

      def perform
        notepad.write_current_day(formatted_new_day) if @new_day
        notepad.read_current_day
      end

      private

      def formatted_new_day
        DayFormatter.new(@new_day).format
      end

      attr_reader :notepad
    end
  end
end

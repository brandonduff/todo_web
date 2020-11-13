module Todo
  module UseCases
    class UseCase
      def self.perform(*args)
        new(notepad: Notepad.new).perform(*args)
      end

      def initialize(notepad:)
        @notepad = notepad
      end
    end
  end
end

module Todo
  class Writer
    def self.for(writable)
      new(writable)
    end

    def initialize(writable="")
      @writable = writable
    end

    def write(output, to:)
      self.class.new(output).write_to(to)
    end

    def write_to(file_path)
      file = File.open(file_path, 'a')
      file.truncate(0)
      file.puts(@writable)
      file.close
    end
  end
end

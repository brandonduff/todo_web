require 'date'

class Date
  def dmy_string
    strftime("%d-%m-%Y")
  end
end

module Todo
  class DayFormatter
    def self.format(date_string)
      new(date_string).format
    end

    def self.today
      Date.today.dmy_string
    end

    def initialize(date_string)
      @date_string = date_string.to_s
    end

    attr_reader :date_string

    def format
      if date_string =~ /\d+-\d+/
        Date.parse(date_string + "-#{Date.today.strftime("%Y")}")
      elsif date_string == "today" || date_string == ""
        Date.today
      else
        Date.parse(date_string)
      end.dmy_string
    end
  end
end

require 'date'

module Todo
  class DayFormatter
    def self.format(date_string)
      new(date_string).format
    end

    def self.today
      Date.today.strftime("%d-%m-%Y")
    end

    def initialize(date_string)
      @date_string = date_string
    end

    attr_reader :date_string

    def format
      if date_string =~ /\d+-\d+/
        parse_current_year_date
      elsif date_string == "today" || date_string == ""
        today
      elsif date_string =~ /\d+-\d+-\d+/
        parse_full_date_string
      else
        parse_relative_day
      end
    end

    def parse_current_year_date
      Date.parse(date_string + "-#{Date.today.strftime("%Y")}").strftime("%d-%m-%Y")
    end

    def today
      self.class.today
    end

    def parse_full_date_string
      Date.parse(date_string).strftime("%d-%m-%Y")
    end

    def parse_relative_day
      Date.parse(date_string).strftime("%d-%m-%Y")
    end
  end
end

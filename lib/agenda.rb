class Agenda
  attr_accessor :current_day

  def self.fresh_for_today
    new(Date.today.iso8601, TaskList.new)
  end

  def initialize(current_day, task_list)
    @current_day = current_day
    @task_list = task_list
    @lists = {}
    @lists[@current_day] = @task_list
  end

  def task_list
    return @lists[@current_day] if @lists[@current_day]
    @lists[@current_day] = TaskList.new
  end

  def all_lists
    @lists.sort_by { |k, _v| k }.reverse.map do |date, list|
      [date, list]
    end
  end
end

class Agenda
  attr_accessor :current_day

  def self.fresh_for_today
     new(Date.today.iso8601, TaskList.new)
  end

  def initialize(current_day, task_list)
    @current_day = current_day
    @task_list = task_list
    @lists = Hash.new { |hash, key| hash[key] = TaskList.new }
    @lists[@current_day] = @task_list
  end

  def task_list
    @lists[@current_day]
  end
end

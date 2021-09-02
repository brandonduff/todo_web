class Agenda
  attr_accessor :current_day
  attr_reader :task_list

  def initialize(current_day, task_list)
    @current_day = current_day
    @task_list = task_list
    @lists = { @current_day => @task_list }
  end

  def add_list_on_day(list, day)
    @lists[day] = list
  end

  def task_list
    @lists[@current_day]
  end
end

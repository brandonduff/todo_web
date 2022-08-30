require "observer"

class Agenda
  include Observable

  attr_reader :current_day

  def initialize(current_day, task_list)
    @current_day = current_day
    @task_list = task_list
    @lists = Hash.new { |hash, key| hash[key] = TaskList.new }
    @lists[@current_day] = @task_list
  end

  def task_list
    @lists[@current_day]
  end

  def current_day=(new_date)
    @current_day = new_date
    notify
  end

  private

  def notify
    changed && notify_observers(self)
  end
end

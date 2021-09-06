class AgendaView < HtmlComponent
  attr_reader :agenda

  def initialize(agenda)
    @agenda = agenda
  end

  def render_content_on(html)
    html.render(current_day_view)
    html.render(task_list_view)
  end

  def task_list_view
    TaskListView.new(agenda.task_list)
  end

  def current_day_view
    CurrentDayView.new(agenda)
  end
end

class AgendaView < HtmlComponent
  def initialize(agenda)
    @current_day = CurrentDayView.new(agenda.current_day)
    @task_list = TaskListView.new(agenda.task_list)
  end

  def render_content_on(html)
    html.render(@current_day)
    html.render(@task_list)
  end
end

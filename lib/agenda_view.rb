class AgendaView < HtmlComponent
  def initialize(agenda)
    @agenda = agenda
  end

  def render_content_on(html)
    html.render(CurrentDayView.new(@agenda.current_day))
    html.render(TaskListView.new(@agenda.task_list))
  end
end

Agenda = Struct.new(:current_day, :task_list)

class TaskListView
  def initialize(list)
    @list = list
  end

  def render_content_on(html)
    @list.each do |todo|
      html.paragraph(todo)
    end
  end
end

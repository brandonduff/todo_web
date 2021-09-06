class MainView < HtmlComponent
  def initialize
    @view = AgendaView.new(Agenda.new(Date.today.iso8601, Todo::TaskList.new))
  end

  def render_content_on(html)
    html.render(@view)
  end
end
class MainView < HtmlComponent
  def initialize(agenda)
    @view = AgendaView.new(agenda)
  end

  def render_content_on(html)
    html.render(@view)
  end
end

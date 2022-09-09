class MainView < HtmlComponent
  def initialize(agendas)
    agenda = agendas.current
    @save_button = SaveButtonView.new(agenda, 'data.store')
    @view = AgendaView.new(agenda)
  end

  def render_content_on(html)
    html.render(@view)
    html.render(@save_button)
  end
end

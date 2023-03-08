class MainView < HtmlComponent
  def initialize(agendas)
    agenda = agendas.current
    @save_button = SaveButtonView.new(agenda, agendas)
    @view = AgendaView.new(agenda)
    @agendas_view = AgendasView.new(agendas)
  end

  def render_content_on(html)
    html.render(@view)
    html.render(@save_button)
    html.render(@agendas_view)
  end
end

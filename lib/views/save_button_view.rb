class SaveButtonView < HtmlComponent
  def initialize(agenda, agendas)
    @agendas = agendas
    @agenda = agenda
  end

  def render_content_on(html)
    html.anchor(:save)
  end

  def save
    @agendas << @agenda
  end
end

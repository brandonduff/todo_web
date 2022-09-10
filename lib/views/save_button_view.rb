class SaveButtonView < HtmlComponent
  def initialize(agenda, filename)
    @agenda = agenda
    @filename = filename
  end

  def render_content_on(html)
    html.anchor(:save)
  end

  def save
    Agendas.create(@filename) << @agenda
  end
end

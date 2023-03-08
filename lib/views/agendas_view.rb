class AgendasView < HtmlComponent
  attr_reader :agendas

  def initialize(agendas)
    @agendas = agendas
  end

  def render_content_on(html)
    agendas.each do |agenda|
      agenda.instance_variable_get(:@lists).each do |_date, task_list|
        task_list.each do |task|
          html.paragraph(task.description)
        end
      end
    end
  end
end

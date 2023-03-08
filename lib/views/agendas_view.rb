class AgendasView < HtmlComponent
  attr_reader :agendas

  def initialize(agendas)
    @agendas = agendas
  end

  def render_content_on(html)
    agendas.each do |agenda|
      agenda.lists.each do |date, task_list|
        html.paragraph(date)
        html.unordered_list do
          task_list.each do |task|
            html.list_item(task.description)
          end
        end
      end
    end
  end
end

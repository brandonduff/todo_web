class CurrentDayView < HtmlComponent
  def initialize(agenda)
    @agenda = agenda
  end

  def date
    @agenda.current_day
  end

  def date=(date)
    @agenda.current_day = date
  end

  def render_content_on(html)
    html.paragraph(date)
    html.new_form do |f|
      f.date_input(:date)
      f.submit_button('Set Current Day')
    end
  end
end
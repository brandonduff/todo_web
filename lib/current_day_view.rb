class CurrentDayView < HtmlComponent
  attr_accessor :date

  def initialize(date)
    @date = date
  end

  def render_content_on(html)
    html.paragraph(@date)
    html.new_form do |f|
      f.date_input(:date)
      f.submit_button
    end
  end
end
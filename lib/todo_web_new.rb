class TodoWebNew < HtmlComponent
  def initialize
    @current_day = CurrentDay.new(Date.today)
  end

  def render_content_on(html)
    html.render(@current_day)
  end
end

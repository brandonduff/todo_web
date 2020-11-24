class MainView < HtmlComponent
  def initialize(todos:, current_day:)
    @todos = todos
    @current_day = current_day
  end

  def render_content_on(html)
    html.head do
      html.stylesheet_link href: 'index.css'
    end

    html.body do
      html.render CurrentDayForm.new(@current_day)
      html.render TodoListView.new(@todos)
      html.render NewTodoForm.new
    end
  end
end

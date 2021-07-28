class TaskView < HtmlComponent
  def initialize(task)
    @task = task
  end

  def render_content_on(html)
    html.list_item(@task)
  end
end
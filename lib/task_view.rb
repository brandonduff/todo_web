class TaskView < HtmlComponent
  def initialize(task)
    @task = task
  end

  def render_content_on(html)
    if @task.done?
      html.del(@task)
    else
      html.text(@task)
    end
  end
end
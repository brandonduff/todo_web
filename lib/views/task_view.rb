class TaskView < HtmlComponent
  def initialize(task)
    @task = task
  end

  def finish
    @task.done
  end

  def render_content_on(html)
    if @task.done?
      html.del(@task.description)
    else
      html.text(@task.description)
    end
    html.text(' | ')
    html.anchor(:finish)
  end
end
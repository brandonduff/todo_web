class TaskView < HtmlComponent
  def initialize(task)
    @task = task
  end

  # TODO: need to update in list. this doesn't work in app. interesting design issue
  def finish
    @task = @task.done
  end

  def render_content_on(html)
    if @task.done?
      html.del(@task)
    else
      html.text(@task)
    end
    html.anchor(:finish)
  end
end
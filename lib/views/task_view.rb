class TaskView < HtmlComponent
  def initialize(task)
    @task = task
  end

  def finish
    @task.done
  end

  def move_up
    @task.move_up
  end

  def move_down
    @task.move_down
  end

  def render_content_on(html)
    if @task.done?
      html.del(@task.description)
    else
      html.text(@task.description)
    end
    html.text(' | ')
    html.anchor(:finish)
    html.text(' | ')
    html.anchor('^', &:move_up)
    html.text(' | ')
    html.anchor('v', &:move_down)
  end
end

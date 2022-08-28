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

  def undo
    @task.undo
  end

  def render_content_on(html)
    description(html)
    html.text(" | ")
    state_toggle(html)
    html.text(" | ")
    html.anchor("^", &:move_up)
    html.text(" | ")
    html.anchor("v", &:move_down)
    html.text(" | ")
  end

  private

  def state_toggle(html)
    @task.done? ? html.anchor(:undo) : html.anchor(:finish)
  end

  def description(html)
    @task.done? ? html.del(@task.description) : html.text(@task.description)
  end
end

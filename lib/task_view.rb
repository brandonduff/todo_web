class TaskView < HtmlComponent
  def initialize(task)
    @task = task
  end

  def render_content_on(html)
    html.list_item do |li|
      if @task.done?
        li.del(@task)
      else
        li.text(@task)
      end
    end
  end
end
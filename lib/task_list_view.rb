class TaskListView < HtmlComponent
  def initialize(list)
    @list = list
  end

  def new_task=(new_task)
    @list << new_task
  end

  def render_content_on(html)
    render_tasks(html)
    render_new_task_form(html)
  end

  private

  def render_tasks(html)
    html.unordered_list do
      @list.each do |task|
        html.list_item(task)
      end
    end
  end

  def render_new_task_form(html)
    html.new_form do |f|
      f.text_input(:new_task)
      f.submit_button('create new task')
    end
  end
end
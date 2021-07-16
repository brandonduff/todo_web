class TaskListView < HtmlComponent
  def initialize(list)
    @list = list
  end

  def new_task=(new_task)
    @list << new_task
  end

  def render_content_on(html)
    html.unordered_list do
      @list.each do |todo|
        html.list_item(todo)
      end
    end

    html.new_form do |f|
      f.text_input(:new_task)
      f.submit_button('create new task')
    end
  end
end
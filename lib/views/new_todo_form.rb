class NewTodoForm < HtmlComponent
  def render_content_on(html)
    html.form action: '/' do
      html.label 'New Todo', for: :create_todo
      html.text_input name: :todo, id: :create_todo
      html.submit_button 'Create'
    end
  end
end

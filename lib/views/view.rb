class View
  def render(renderable)
    renderable.render_content_on(self)
  end
end

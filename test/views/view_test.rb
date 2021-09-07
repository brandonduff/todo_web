class ViewTest < Minitest::Test
  def canvas
    @canvas ||= TestCanvas.build
  end
end
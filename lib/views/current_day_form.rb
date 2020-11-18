class CurrentDayForm < HTMLComponent
  attr_reader :current_day

  def initialize(current_day)
    @current_day = current_day
  end

  def render_content_on(html)
    html.label 'Current Day', for: 'current_day'
    html.form action: '/current_day' do
      html.date_input id: 'current_day', name: 'current_day', value: current_day
      html.submit_button 'Change Date'
    end
    html.form action: '/current_day' do
      html.submit_button 'Today'
    end
  end
end

require 'rspec'
require 'ostruct'
require 'todo_presenter'

describe TodoWeb::TodoPresenter do
  let(:todo) { double(description: 'foo', done?: false) }
  let(:todo_two) { double(description: 'bar', done?: false) }
  let(:todos) { [todo, todo_two] }

  it 'should present undone todos as strings' do
    expect(subject.present(todos)).to eq(%w(foo bar))
  end

  context 'with done todos' do
    let(:todo) { double(description: 'bar', done?: true) }
    let(:todos) { [todo] }

    it 'should present them wrapped in del' do
      expect(subject.present(todos)).to eq(['<del>bar</del>'])
    end
  end
end
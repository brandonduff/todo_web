require 'rspec'
require 'ostruct'
require 'todo_presenter'
require 'escaped_collection'
require 'todo/task'

describe TodoWeb::TodoPresenter do
  let(:todo) { Todo::Task.new('foo', false) }
  let(:todo_two) { Todo::Task.new('bar', false) }
  let(:todos) { [todo, todo_two] }

  before do
    expect(EscapedCollection).to receive(:from).with(todos).and_return(todos)
  end

  it 'should present undone todos as strings' do
    expect(subject.present(todos)).to eq(%w(foo bar))
  end

  context 'with done todos' do
    let(:todo) { Todo::Task.new('done', true) }

    it 'should strip out checkmarks' do
      expect(subject.present(todos)).to include('<del>done</del>')
    end
  end

  context 'with done todos' do
    let(:todo) { Todo::Task.new('bar', true) }
    let(:todos) { [todo] }

    it 'should present them wrapped in del' do
      expect(subject.present(todos)).to eq(['<del>bar</del>'])
    end
  end
end

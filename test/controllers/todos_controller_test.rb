require 'test_helper'

class TodosControllerTest < ActionController::TestCase

  def test_index
    IndexTests.new.all_stub do |samples|
      get :index

      samples.each do |s|
        assert_select('li h1', s.name)
        assert_select('li p', s.description)
      end

      assert_select('li p', 'Completed')
    end
  end

end

class IndexTests

  def all_stub
    sample_todo = Todo.new(
      name: '1',
      description: 'description 1',
      completed: true
    )
    sample_todo_2 = Todo.new(
      name: '2',
      description: 'description 2'
    )
    samples = [sample_todo, sample_todo_2]

    Todo.stub :all, samples do
      yield samples
    end
  end

end

require 'test_helper'

class TodosControllerTest < ActionController::TestCase
  # Index tests
  def test_index_displays_all_todos
    get :index

    Todo.all.each do |s|
      assert_select('li h1', s.name)
      assert_select('li p', s.description)
    end

    assert_select('li p', text: 'Completed', count: 1)
  end

  def test_index_with_no_todos
    Todo.delete_all

    get :index

    assert_select('.alert p', 'No Todo items found')
  end

  # Show tests
  def test_show_displays_todo
    get :show, id: Todo.first.id

    assert_select('h1', Todo.first.name)
  end

  def test_show_displays_completed_todo
    completed_todo = Todo.find_by(completed: true)

    get :show, id: completed_todo.id

    assert_select('h1.todo__completed', completed_todo.name)
    assert_select('p', completed_todo.description)
  end

  def test_show_displays_uncompleted_todo_without_completed_class
    incomplete_todo = Todo.find_by(completed: false)

    get :show, id: incomplete_todo.id

    assert_empty(css_select('h1.todo__completed'))
  end

  # Create tests
  def test_create_succeeds_redirects_to_show
    new_todo = Todo.new(name: 'Some name')

    post :create, todo: {name: new_todo.name}

    assert Todo.find_by(name: new_todo.name)
    assert_redirected_to action: :show,
                         controller: :todos,
                         id: Todo.order(:created_at).last.id
  end

  def test_create_fails_renders_new
    post :create, todo: {description: 'something'}

    # TODO: Until I show errors, this is fine.
    assert_select('label', count: 2) do |elements|
      assert_select elements.first.name, I18n.t('todos.new.name_label')
      assert_select elements[1].name, I18n.t('todos.new.description_label')
    end
  end
end
